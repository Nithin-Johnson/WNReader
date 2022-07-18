import 'package:WNReader/App/Sources/en/Scrapers/BoxNovelScraper.dart';
import 'package:WNReader/App/Sources/en/Scrapers/NovelFullScraper.dart';

import 'en/BoxNovel.dart';
import 'en/NovelFull.dart';
import 'en/RoyalRoad.dart';

Map<int, dynamic> scraperList = {
  1: BoxNovelScraper(),
  2: NovelFullScraper(),
};

final sourceList = [BoxNovel(), NovelFull(), RoyalRoad()];

List sourceDetails = [  {
    "id": 1,
    "name": "Box Novel",
    "icon": "https://boxnovel.me/static/sites/boxnovel/icons/favicon.ico"
  },  {
    "id": 2,
    "name": "Novel Full",
    "icon": "https://novelfull.com/web/images/favicon.ico",
  },  {
    "id": 3,
    "name": "Royal Road",
    "icon": "https://www.royalroad.com/icons/android-chrome-192x192.png",
  }, ];
