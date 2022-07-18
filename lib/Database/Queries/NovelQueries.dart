import 'package:sqflite/sqflite.dart';
import 'package:WNReader/Database/Database.dart';

Future<int> insertNovel(novel) async {
  Database? db = await DatabaseHelper.instance.database;
  const insertNovelQuery =
      'INSERT INTO novels (novelUrl, sourceUrl, sourceId, source, novelName, novelCover, novelSummary) VALUES(?, ?, ?, ?, ?, ?, ?)';

  int insertId = await db.rawInsert(
    insertNovelQuery,
    [
      novel['novelUrl'],
      novel['sourceUrl'],
      novel['sourceId'],
      novel['source'],
      novel['novelName'],
      novel['novelCover'],
      novel['novelSummary'],
    ],
  );
  return insertId;
}

followNovel(novelId) async {
  Database? db = await DatabaseHelper.instance.database;
  await db.rawUpdate(
    'UPDATE novels SET followed = ? WHERE novelId = ?',
    [1, novelId],
  );
}

unfollowNovel(novelId) async {
  Database? db = await DatabaseHelper.instance.database;

  await db.rawUpdate(
    'UPDATE novels SET followed = ? WHERE novelId = ?',
    [0, novelId],
  );
}

Future<bool> checkNovelInCache(novelUrl) async {
  Database? db = await DatabaseHelper.instance.database;
  const checkNovelInCacheQuery = 'SELECT * FROM novels WHERE novelUrl=? LIMIT 1';
  bool? inCache;
  List novel = await db.rawQuery(
    checkNovelInCacheQuery,
    [novelUrl],
  );
  if (novel.length != 0) {
    inCache = true;
  } else {
    inCache = false;
  }
  return inCache;
}

Future<Map> getNovel(sourceId, novelUrl) async {
  Database? db = await DatabaseHelper.instance.database;
  List novels = await db.rawQuery(
    'SELECT * FROM novels WHERE novelUrl = ? AND sourceId = ?',
    [novelUrl, sourceId],
  );
  Map novel = {};
  novel.addAll(novels[0]);
  return novel;
}

deleteNovelCache() async {
  Database? db = await DatabaseHelper.instance.database;
  await db.rawDelete(
    'DELETE FROM novels WHERE followed = 0',
  );
}
