import 'package:sqflite/sqflite.dart';
import 'package:WNReader/Database/Database.dart';

const getUpdatesFromDbQuery = '''
SELECT chapters.chapterId,
chapters.read,
chapters.downloaded,
chapters.chapterUrl,
chapters.chapterName,
chapters.bookmark,
chapters.releaseDate,
novels.novelUrl,
novels.novelId,
novels.novelCover,
novels.novelName,
novels.sourceId,
updates.updateTime,
updates.updateId
FROM updates 
JOIN chapters ON updates.chapterId = chapters.chapterId 
JOIN novels ON updates.novelId = novels.novelId 
WHERE date(updates.updateTime) > date('now','-3 months') 
ORDER BY updates.updateTime DESC
''';

getUpdatesFromDB() async {
  Database? db = await DatabaseHelper.instance.database;
  await db.rawQuery(getUpdatesFromDbQuery);
}

const insertChapterUpdateQuery = '''
INSERT OR IGNORE INTO updates (chapterId, novelId, updateTime) 
VALUES (?, ?, (datetime('now','localtime')))
''';

insertChapterUpdate(chapterId, novelId) async {
  Database? db = await DatabaseHelper.instance.database;

  db.execute(
    insertChapterUpdateQuery,
    [chapterId, novelId],
  );
}

deleteUpdateFromDB(novelId) async {
  Database? db = await DatabaseHelper.instance.database;
  const deleteUpdateFromDbQuery = 'DELETE FROM updates WHERE novelId = ?';

  db.rawDelete(
    deleteUpdateFromDbQuery,
    [novelId],
  );
}

clearUpdates() async {
  Database? db = await DatabaseHelper.instance.database;
  const clearUpdatesQuery = 'DELETE FROM updates; VACCUM;';

  db.rawDelete(clearUpdatesQuery);
}
