import 'package:WNReader/App/Services/source.dart';
import 'package:WNReader/Database/Queries/ChapterQueries.dart';
import 'package:WNReader/Database/Queries/LibraryQueries.dart';
import 'package:WNReader/Database/Queries/NovelQueries.dart';

Future<Map> getNovelAction(sourceId, novelUrl) async {
  bool novelInCache = await checkNovelInCache(novelUrl);
  Map novel = {};
  if (novelInCache) {
    novel = await getNovel(sourceId, novelUrl);
    novel['chapters'] = await getChapters(novel['novelId']);
  } else {
    Map fetchedNovel = await fetchNovel(sourceId, novelUrl);
    int fetchedNovelId = await insertNovel(fetchedNovel);
    await insertChapters(fetchedNovelId, fetchedNovel['chapters']);
    novel = await getNovel(sourceId, novelUrl);
    novel['chapters'] = await getChapters(novel['novelId']);
  }
  return novel;
}

followNovelAction(novel) async{
  await followNovel(novel['novelId']);
}

unfollowNovelAction(novel) async{
  await unfollowNovel(novel['novelId']);
}

Future<List> getLibraryNovelsAction() async {
  return getLibrary();
}