import 'package:WNReader/App/Sources/sourceManager.dart';

Future<Map> fetchNovel(sourceID, novelURL) async{

  var source = scraperList[sourceID];
  Map res = await source.parseNovelAndChapters(novelURL);
  Map novel = {
    'novelUrl': res['novelUrl'],
    'sourceUrl': res['url'],
    'source': res['sourceName'],
    'sourceId': res['sourceId'],
    'novelName': res['novelName'],
    'novelCover': res['novelCover'],
    'novelSummary': res['summary'],
    'followed': 0,
    'chapters': res['chapters'],
  };
  return novel;
}

Future<Map> fetchChapter(sourceID, novelURL, chapterURL) async{

  var source = scraperList[sourceID];
  var chapter = await source.parseChapter(novelURL, chapterURL);

  return chapter;
}

Future<List> fetchChapters(sourceID, novelURL) async{

  var source = scraperList[sourceID];
  var res = await source.parseNovelAndChapters(novelURL);

  List chapters = res['chapters'];

  return chapters;
}