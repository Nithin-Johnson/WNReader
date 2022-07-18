import 'package:sqflite/sqflite.dart';
import 'package:WNReader/Database/Database.dart';

import '../../App/Services/source.dart';

const getLibraryQuery = '''
SELECT novels.*, C.chaptersUnread, D.chaptersDownloaded
FROM novels 
LEFT JOIN 
(SELECT chapters.novelId, COUNT(*) AS chaptersUnread 
FROM chapters 
WHERE chapters.read = 0 
GROUP BY chapters.novelId) AS C
ON novels.novelId = C.novelId 
LEFT JOIN 
(SELECT chapters.novelId, COUNT(*) AS chaptersDownloaded 
FROM chapters 
WHERE chapters.downloaded = 1 
GROUP BY chapters.novelId) AS D 
ON novels.novelId = D.novelId 
WHERE novels.followed = 1
''';

Future<List> getLibrary() async {
  Database? db = await DatabaseHelper.instance.database;
  List libraryNovels = await db.rawQuery(getLibraryQuery);
  return libraryNovels;
}

searchLibraryQuery(searchText) => '''
SELECT novels.*, C.chaptersUnread, D.chaptersDownloaded, H.lastReadAt 
FROM novels 
LEFT JOIN ( 
SELECT chapters.novelId, COUNT(*) AS chaptersUnread 
FROM chapters 
WHERE chapters.read = 0 
GROUP BY chapters.novelId) AS C 
ON novels.novelId = C.novelId 
LEFT JOIN ( 
SELECT chapters.novelId, COUNT(*) AS chaptersDownloaded 
FROM chapters 
WHERE chapters.downloaded = 1 
GROUP BY chapters.novelId) AS D 
ON novels.novelId = D.novelId 
LEFT JOIN ( 
SELECT history.historyNovelId as novelId, historyTimeRead AS lastReadAt 
FROM history 
GROUP BY history.historyNovelId 
HAVING history.historyTimeRead = MAX(history.historyTimeRead) 
ORDER BY history.historyTimeRead DESC) AS H 
ON novels.novelId = H.novelId 
WHERE novels.followed = 1 AND novelName 
LIKE '%${searchText}%'
''';

Future<List> searchLibrary(searchText, sort, filter) async {
  Database? db = await DatabaseHelper.instance.database;

  List searchedNovels = await db.rawQuery(searchLibraryQuery(searchText));

  return searchedNovels;
}

updateNovel(sourceId, novelUrl, novelId) async{
  Database? db = await DatabaseHelper.instance.database;
  Map fetchedNovel = await fetchNovel(sourceId, novelUrl);
  for (Map chapter in fetchedNovel["chapters"]) {
    await db.rawInsert(
      'INSERT OR IGNORE INTO chapters (chapterUrl, chapterName, novelId) values (?, ?, ?)',
      [
        chapter['chapterUrl'],
        chapter['chapterName'],
        novelId,
      ],
    );
  }
}