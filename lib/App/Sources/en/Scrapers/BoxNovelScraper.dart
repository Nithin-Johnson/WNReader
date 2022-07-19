import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

String baseUrl = "https://boxnovel.me";

class BoxNovelScraper {

  /*
    * Parse all the novels on the given page of website.
  */

  Future<Map> latestNovel(page) async {
    int totalPages = 85;
    List novels = [];

    String url = "${baseUrl}/latest?page=" + page.toString();

    final result = await http.get(Uri.parse(url));
    final body = result.body;
    final html = parser.parse(body);

    final neededHtml = html.querySelectorAll('div.section-body > div.list > .book-item');

    for (int j = 0; j < neededHtml.length; j++) {
      String? novelName = neededHtml[j].querySelector('.title > h3 > a')?.text;

      String? novelCover = neededHtml[j].querySelector('img')?.attributes['data-src'];

      novelCover = 'https:' + novelCover!;

      String? novelUrl =
          neededHtml[j].querySelector('.title > h3 > a')?.attributes['href']?.substring(1);

      novelUrl = '${novelUrl}/';

      Map<String, dynamic> novel = {
        'sourceId': 1,
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

    String url = '${baseUrl}/${novelURL}';

    final result = await http.get(Uri.parse(url));
    final body = result.body;
    final html = parser.parse(body);

    novel['sourceName'] = 'Box Novel';
    novel['sourceId'] = 1;
    novel['url'] = url;
    novel['novelUrl'] = novelURL;
    novel['novelName'] = html.querySelector('.name > h1')!.text;
    novel['novelCover'] =
        'https:' + html.querySelector('.img-cover > img')!.attributes['data-src'].toString();
    novel['summary'] = html.querySelector('.content')!.text.trim();
    novel['author'] = html.querySelector('.meta.box > p > a')?.text.trim();

    Future<List> getChapters() async {
      String chapterListUrl = '${baseUrl}/api/novels/${novelURL}chapters';
      List novelChapters = [];

      final result = await http.get(Uri.parse(chapterListUrl));
      final body = result.body;
      final html = parser.parse(body);

      final neededHtml = html.querySelectorAll('select > option');
      int length = neededHtml.length - 1, j;

      for (j = length; j > 0; j--) {
        String? chapterName = neededHtml[j].text;
        String? chapterUrl = neededHtml[j].attributes['value']?.replaceAll('/${novelURL}', '');
        novelChapters.add({
          'chapterName': chapterName,
          'chapterUrl': chapterUrl,
        });
      }
      return novelChapters;
    }

    novel['chapters'] = await getChapters();

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

    String? chapterName = html.querySelector('.chapter__content > h1')?.text.trim();
    String? chapterText =
        html.querySelector('.content-inner')?.innerHtml.replaceAll(RegExp(r'(<p>)(<\/p>)'), '');

    chapter['chapterName'] = chapterName;
    chapter['chapterText'] = chapterText;

    return chapter;
  }
}
