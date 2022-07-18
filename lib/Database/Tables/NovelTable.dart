const createNovelTableQuery = """CREATE TABLE IF NOT EXISTS novels(
novelId INTEGER PRIMARY KEY AUTOINCREMENT,
novelUrl TEXT NOT NULL,
sourceUrl TEXT NOT NULL,
sourceId INTEGER NOT NULL,
source TEXT NOT NULL,
novelName TEXT NOT NULL,
novelCover TEXT,
novelSummary TEXT,
followed INTEGER DEFAULT 0,
unread INTEGER DEFAULT 1
)""";

const createUrlIndexQuery = 'CREATE INDEX IF NOT EXISTS novelUrlIndex ON novels(novelUrl)';

const createLibraryIndexQuery = 'CREATE INDEX IF NOT EXISTS novelFollowedIndex ON novels(followed)';
