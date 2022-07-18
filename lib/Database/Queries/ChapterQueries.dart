import 'package:sqflite/sqflite.dart';
import 'package:WNReader/Database/Database.dart';
import 'package:WNReader/App/Services/source.dart';

insertChapters(novelId, chapters) async {
  Database? db = await DatabaseHelper.instance.database;
  const insertChaptersQuery =
      'INSERT INTO chapters (chapterUrl, chapterName, novelId) values (?, ?, ?)';

  for (Map chapter in chapters) {
    await db.rawInsert(
      insertChaptersQuery,
      [
        chapter['chapterUrl'],
        chapter['chapterName'],
        novelId,
      ],
    );
  }
}

Future<List> getChapters(novelId) async {
  Database? db = await DatabaseHelper.instance.database;
  const getChaptersQuery = 'SELECT * FROM chapters WHERE novelId = ?';
  List chapters = await db.rawQuery(
    getChaptersQuery,
    [novelId],
  );
  return chapters;
}

Future<Map> getChapterFromDB(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  Map chapter = {};
  const getChapterQuery = 'SELECT * FROM downloads WHERE downloadChapterId = ?';

  List chapters = await db.rawQuery(
    getChapterQuery,
    [chapterId],
  );
  chapter.addAll(chapters[0]);
  return chapter;
}

getPrevChapter(novelId, chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  Map chapter = {};
  const getPrevChapterQuery = 'SELECT * FROM chapters WHERE novelId = ? AND chapterId < ?';

  List chapters = await db.rawQuery(
    getPrevChapterQuery,
    [novelId, chapterId],
  );
  chapter.addAll(chapters[chapters.length - 1]);

  return chapter;
}

getNextChapter(novelId, chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  Map chapter = {};
  const getNextChapterQuery = 'SELECT * FROM chapters WHERE novelId = ? AND chapterId > ?';

  List chapters = await db.rawQuery(
    getNextChapterQuery,
    [novelId, chapterId],
  );
  chapter.addAll(chapters[0]);

  return chapter;
}

markChapterRead(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const markChapterReadQuery = 'UPDATE chapters SET \'read\' = 1 WHERE chapterId = ?';

  db.rawUpdate(
    markChapterReadQuery,
    [chapterId],
  );
}

markChapterUnread(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const markChapterUnreadQuery = 'UPDATE chapters SET \'read\' = 0 WHERE chapterId = ?';

  db.rawUpdate(
    markChapterUnreadQuery,
    [chapterId],
  );
}

markAllChaptersRead(novelId) async {
  Database? db = await DatabaseHelper.instance.database;
  const markAllChaptersReadQuery = 'UPDATE chapters SET \'read\' = 1 WHERE novelId = ?';

  db.rawUpdate(
    markAllChaptersReadQuery,
    [novelId],
  );
}

markAllChaptersUnread(novelId) async {
  Database? db = await DatabaseHelper.instance.database;
  const markAllChaptersUnreadQuery = 'UPDATE chapters SET \'read\' = 0 WHERE novelId = ?';

  db.rawUpdate(
    markAllChaptersUnreadQuery,
    [novelId],
  );
}

Future<bool> isChapterDownloaded(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const isChapterDownloadedQuery = 'SELECT * FROM downloads WHERE downloadChapterId=?';

  bool? downloaded;

  List downloads = await db.rawQuery(
    isChapterDownloadedQuery,
    [chapterId],
  );

  if (downloads.length != 0) {
    downloaded = true;
  } else {
    downloaded = false;
  }
  return downloaded;
}

downloadChapter(sourceId, novelUrl, chapterUrl, chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const downloadChapterQuery =
      'INSERT INTO downloads (downloadChapterId, chapterName, chapterText) VALUES (?, ?, ?)';

  Map chapter = await fetchChapter(
    sourceId,
    novelUrl,
    chapterUrl,
  );

  db.rawUpdate(
    'UPDATE chapters SET downloaded = 1 WHERE chapterId = ?',
    [chapterId],
  );
  db.rawInsert(
    downloadChapterQuery,
    [
      chapterId,
      chapter['chapterName'],
      chapter['chapterText'],
    ],
  );
}

deleteChapter(chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const updateIsDownloadedQuery = 'UPDATE chapters SET downloaded = 0 WHERE chapterId=?';
  const deleteChapterQuery = 'DELETE FROM downloads WHERE downloadChapterId=?';

  db.rawUpdate(
    updateIsDownloadedQuery,
    [chapterId],
  );

  db.rawDelete(
    deleteChapterQuery,
    [chapterId],
  );
}

Future<Map> getLastReadChapter(novelId) async {
  Database? db = await DatabaseHelper.instance.database;

  Map chapter = {};

  const getLastReadChapterQuery = '''SELECT chapters.* 
  FROM history 
  JOIN chapters 
  ON history.historyChapterId = chapters.chapterId 
  WHERE history.historyNovelId = ?''';

  List chapters = await db.rawQuery(
    getLastReadChapterQuery,
    [novelId],
  );
  chapter.addAll(chapters[0]);
  return chapter;
}

bookmarkChapter(bookmark, chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  const bookmarkChapterQuery = 'UPDATE chapters SET bookmark = ? WHERE chapterId = ?';

  db.rawUpdate(
    bookmarkChapterQuery,
    [bookmark, chapterId],
  );
}

markPrevChaptersRead(chapterId, novelId) async {
  Database? db = await DatabaseHelper.instance.database;

  const markPrevChaptersReadQuery =
      'UPDATE chapters SET \'read\' = 1 WHERE chapterId < ? AND novelId = ?';

  db.rawUpdate(
    markPrevChaptersReadQuery,
    [chapterId, novelId],
  );
}

markPreviousChaptersUnread(chapterId, novelId) async {
  Database? db = await DatabaseHelper.instance.database;

  const markPrevChaptersUnreadQuery =
      'UPDATE chapters SET \'read\' = 0 WHERE chapterId < ? AND novelId = ?';

  db.rawUpdate(
    markPrevChaptersUnreadQuery,
    [chapterId, novelId],
  );
}

Future<List> getDownloadedChapters() async {
  Database? db = await DatabaseHelper.instance.database;

  const getDownloadedChaptersQuery = '''
  SELECT chapters.*, novels.sourceId, novels.novelName, novels.novelCover, novels.novelUrl 
  FROM chapters 
  JOIN novels 
  ON chapters.novelId = novels.novelId 
  WHERE chapters.downloaded = 1''';

  List downloadedChapters = await db.rawQuery(getDownloadedChaptersQuery);

  return downloadedChapters;
}

deleteDownloads() async {
  Database? db = await DatabaseHelper.instance.database;

  db.rawUpdate('UPDATE chapters SET downloaded = 0');
  db.rawDelete('DELETE FROM downloads; VACCUM;');
}

const updateChapterDownloadedQuery = 'UPDATE chapters SET downloaded = 1 WHERE chapterId = ?';

const updateChapterDeletedQuery = 'UPDATE chapters SET downloaded = 0 WHERE chapterId = ?';
