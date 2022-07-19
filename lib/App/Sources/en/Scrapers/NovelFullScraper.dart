import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

String baseUrl = "https://novelfull.com";

class NovelFullScraper {
  /*
    * Parse all the novels on the given page of website.
  */

  Future<Map> latestNovel(page) async {
    int totalPages = 55;
    List novels = [];

    String url = "${baseUrl}/latest-release-novel?page=" + page.toString();

    final result = await http.get(Uri.parse(url));
    final body = result.body;
    final html = parser.parse(body);

    final neededHtml = html.querySelectorAll('div.col-truyen-main > div.list-truyen > .row');

    for (int j = 0; j < neededHtml.length; j++) {
      String? novelName = neededHtml[j].querySelector('h3.truyen-title > a')?.text;
      String? novelCover = neededHtml[j].querySelector('img')?.attributes['src'];
      novelCover = baseUrl + novelCover!;
      String? novelUrl = neededHtml[j]
          .querySelector('h3.truyen-title > a')
          ?.attributes['href']
          ?.replaceAll('.html', '')
          .substring(1);
      novelUrl = '${novelUrl}/';

      Map<String, dynamic> novel = {
        'sourceId': 2,
        'novelUrl': novelUrl,
        'novelName': novelName,
        'novelCover': novelCover,
      };
      novels.add(novel);
    }

    return {
      'totalPages': totalPages,
      'novels': novels,
    };
  }

  /*
    * Parse individual novel and it's chapters.
  */

  Future<Map> parseNovelAndChapters(String novelURL) async {
    Map<String, dynamic> novel = {};

    String url = '${baseUrl}/${novelURL.substring(0, novelURL.length - 1)}.html';

    final result = await http.get(Uri.parse(url));
    final body = result.body;
    final html = parser.parse(body);

    novel['sourceName'] = 'Novel Full';
    novel['sourceId'] = 2;
    novel['url'] = url;
    novel['novelUrl'] = novelURL;
    novel['novelName'] = html.querySelector('div.book > img')!.attributes['alt'];
    novel['novelCover'] =
        baseUrl + html.querySelector('div.book > img')!.attributes['src'].toString();
    novel['summary'] = html.querySelector('div.desc-text')!.text.trim();
    novel['author'] = html.querySelector('div.info > div > h3')!.nextElementSibling?.text;

    String? novelId = html.querySelector('#rating')!.attributes['data-novel-id'];

    Future<List> getChapters(Id) async {
      String chapterListUrl = baseUrl + '/ajax/chapter-option?novelId=' + Id;
      List novelChapters = [];

      final result = await http.get(Uri.parse(chapterListUrl));
      final body = result.body;
      final html = parser.parse(body);

      final neededHtml = html.querySelectorAll('select > option');

      for (int j = 0; j < neededHtml.length; j++) {
        String? chapterName = neededHtml[j].text;
        String? chapterUrl = neededHtml[j].attributes['value']?.replaceAll('/${novelURL}', '');

        novelChapters.add({'chapterName': chapterName, 'chapterUrl': chapterUrl});
      }
      return novelChapters;
    }

    novel['chapters'] = await getChapters(novelId);

    return novel;
  }

  /*
    * Parse individual chapter.
  */

  Future<Map> parseChapter(novelURL, chapterURL) async {
    Map<String, dynamic> chapter = {};

    String url = '${baseUrl}/${novelURL}${chapterURL}';
    final result = await http.get(Uri.parse(url));
    final body = result.body;
    final html = parser.parse(body);

    String? chapterName = html.querySelector('.chapter-text')?.text;
    String? chapterText =
        html.querySelector('#chapter-content')?.innerHtml.replaceAll(RegExp(r'(<p>)(<\/p>)'), '');
    // Iterable<RegExpMatch> match =  RegExp(r'(?<=<p>)(.*?)(?=</p>)').allMatches(chapterText!);
    // String chapterTexts='',italic='';
    // for (final m in match)
    // {
    //   chapterTexts = chapterTexts + m.group(0)! + '\n\n';
    // }
    chapter['chapterName'] = chapterName;
    chapter['chapterText'] = chapterText;

    return chapter;
  }
}
