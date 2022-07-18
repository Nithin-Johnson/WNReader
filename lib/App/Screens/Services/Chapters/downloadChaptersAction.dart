import 'package:WNReader/Database/Queries/ChapterQueries.dart';

downloadAllChaptersAction(novel) async{
  List novelChapters = novel['chapters'];
  for(int i=0; i<novelChapters.length;i++){
    if(novelChapters[i]['downloaded']==0){
      await downloadChapter(novel['sourceId'], novel['novelUrl'], novelChapters[i]['chapterUrl'], novelChapters[i]['chapterId']);
    }
  }
}
downloadUnreadChaptersAction(novel) async{
  List novelChapters = novel['chapters'];
  for(int i=0; i<novelChapters.length;i++){
    if(novelChapters[i]['downloaded']==0 && novelChapters[i]['\'read\'']==0){
      await downloadChapter(novel['sourceId'], novel['novelUrl'], novelChapters[i]['chapterUrl'], novelChapters[i]['chapterId']);
    }
  }
}