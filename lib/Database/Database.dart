import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Tables/ChapterTable.dart';
import 'Tables/NovelTable.dart';
import 'Tables/HistoryTable.dart';
import 'Tables/DownloadTable.dart';
import 'Tables/UpdateTable.dart';


class DatabaseHelper {
  static final _databaseName = "wnreader.db";
  static final _databaseVersion = 1;

  // *make this a singleton class
  static final DatabaseHelper instance = DatabaseHelper._();
  DatabaseHelper._();

  // *only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // *lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // *this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // *SQL code to create the database table
  Future _onCreate(Database db, int version) async {

    await db.transaction((txn) async {

      // *Tables
      await txn.execute(createNovelTableQuery);
      await txn.execute(createChapterTableQuery);
      await txn.execute(createHistoryTableQuery);
      await txn.execute(createDownloadTableQuery);
      await txn.execute(createUpdatesTableQuery);

      // *Indexes
      await txn.execute(createNovelIdIndexQuery);
      await txn.execute(createUnreadChaptersIndexQuery);
      await txn.execute(createUrlIndexQuery);
      await txn.execute(createLibraryIndexQuery);
      await txn.execute(createChapterIdIndexQuery);
    });
  }
}
