import 'package:sqflite/sqflite.dart';
import 'package:WNReader/Database/Database.dart';
import 'package:WNReader/App/Services/source.dart';
import 'ChapterQueries.dart';

fetchAndInsertChapterInDB(sourceId, novelUrl, chapterId, chapterUrl) async {
  Database? db = await DatabaseHelper.instance.database;

  const downloadChapterQuery = '''INSERT INTO 
  downloads (downloadChapterId, chapterName, chapterText) 
  VALUES (?, ?, ?)''';

  Map chapter = await fetchChapter(sourceId, novelUrl, chapterUrl);

  db.transaction((txn) async {
    txn.rawUpdate(
      updateChapterDownloadedQuery,
      [chapterId],
    );
    txn.rawInsert(
      downloadChapterQuery,
      [
        chapterId,
        chapter['chapterName'],
        chapter['chapterText'],
      ],
    );
  });
}

deleteChapterFromDB(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const deleteChapterFromDbQuery = '''DELETE FROM downloads 
  WHERE downloadChapterId = ?''';

  db.transaction((txn) async {
    txn.rawUpdate(
      updateChapterDeletedQuery,
      [chapterId],
    );
    txn.rawDelete(
      deleteChapterFromDbQuery,
      [chapterId],
    );
  });
}

getChapterFromDB(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  Map chapter = {};

  const getChapterFromDbQuery = '''
  SELECT * FROM downloads 
  WHERE downloadChapterId = ?''';

  db.transaction((txn) async {
    txn.rawQuery(
      getChapterFromDbQuery,
      [chapterId],
    ).then((value) {
      chapter.addAll(value[0]);
    });
  });
  return chapter;
}

const deleteReadChaptersFromDbQuery = '''
DELETE FROM downloads 
WHERE downloads.downloadChapterId 
IN (SELECT chapters.chapterId 
FROM downloads 
INNER JOIN chapters 
ON chapters.chapterId = downloads.downloadChapterId 
WHERE chapters.read = 1);
''';

const updateChaptersDeletedQuery = '''
UPDATE chapters 
SET downloaded = 0 
WHERE chapters.chapterId 
IN (SELECT downloads.downloadChapterId 
FROM downloads 
INNER JOIN chapters 
ON chapters.chapterId = downloads.downloadChapterId 
WHERE chapters.read = 1);
''';

deleteReadChaptersFromDB(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;

  db.transaction((txn) async {
    txn.rawUpdate(
      updateChaptersDeletedQuery,
    );
    txn.rawDelete(
      deleteReadChaptersFromDbQuery,
    );
  });
}
