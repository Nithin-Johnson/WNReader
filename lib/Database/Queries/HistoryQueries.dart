import 'package:sqflite/sqflite.dart';
import 'package:WNReader/Database/Database.dart';

const getHistoryQuery = '''
SELECT history.*, chapters.*, novels.*
FROM history 
JOIN chapters 
ON history.historyChapterId = chapters.chapterId 
JOIN novels 
ON history.historyNovelId = novels.novelId 
GROUP BY novels.novelId 
HAVING history.historyTimeRead = MAX(history.historyTimeRead) 
ORDER BY history.historyTimeRead DESC
''';

getHistoryFromDB() async {
  Database? db = await DatabaseHelper.instance.database;

  return db.transaction((txn) async {
    await txn.rawQuery(getHistoryQuery);
  });
}

insertHistory(novelId, chapterId) async {
  Database? db = await DatabaseHelper.instance.database;
  db.transaction((txn) async {
    txn.execute(
      "INSERT OR REPLACE INTO history (historyNovelId, historyChapterId, historyTimeRead) VALUES (?, ?, (datetime('now','localtime')))",
      [novelId, chapterId],
    );
    txn.rawUpdate(
      'UPDATE novels SET unread = 0 WHERE novelId = ?',
      [novelId],
    );
  });
}

deleteChapterHistory(historyId) async {
  Database? db = await DatabaseHelper.instance.database;

  db.transaction((txn) async {
    txn.rawDelete(
      'DELETE FROM history WHERE historyId = ?',
      [historyId],
    );
  });
}

deleteAllHistory() async {
  Database? db = await DatabaseHelper.instance.database;

  db.transaction((txn) async {
    txn.rawDelete(
      'DELETE FROM history; VACCUM;',
    );
  });
}
