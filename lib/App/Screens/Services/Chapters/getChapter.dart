
import 'package:WNReader/Database/Queries/ChapterQueries.dart';

import '../../../Services/source.dart';

Future<Map> getChapterAction(sourceId, novelUrl, chapterUrl, chapterId) async{
  bool chapterInCache = await isChapterDownloaded(chapterId);
  Map chapter = {};

  if(chapterInCache){
    chapter = await getChapterFromDB(chapterId);
  }else{
    chapter = await fetchChapter(
      sourceId,
      novelUrl,
      chapterUrl,
    );
  }
  return chapter;
}