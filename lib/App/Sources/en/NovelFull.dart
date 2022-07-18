import 'package:flutter/material.dart';
import '../Components/getNovelCards.dart';
import 'Scrapers/NovelFullScraper.dart';

class NovelFull extends StatefulWidget {
  const NovelFull({Key? key}) : super(key: key);

  @override
  State<NovelFull> createState() => _NovelFullState();
}

class _NovelFullState extends State<NovelFull> {
  late Future<Map> latestNovel;
  ScrollController controller = ScrollController();

  late final Future? getNovelsFuture;
  bool hasMore = true, isLoading = false;
  late int page = 1, limit;
  List Novels = [];
  late int sourceID;
  @override
  void initState() {
    super.initState();
    getNovelsFuture = getNovels(page);
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        getNovels(page);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future getNovels(Page) async {
    if (isLoading) return;
    isLoading = true;
    latestNovel = NovelFullScraper().latestNovel(Page);
    Novels.addAll((await latestNovel)['novels']);
    sourceID = (await latestNovel)['novels'][0]['sourceId'];
    limit = (await latestNovel)['totalPages'];
    if (page < limit) {
      setState(() {
        page++;
        isLoading = false;
        if (page > limit) {
          hasMore = false;
        }
      });
    }
    return {'novels': Novels, 'sourceId' : sourceID};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Novel Full'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.view_list_rounded))
          ],
          elevation: 0,
        ),
        body: getNovelCards(
            getNovelFuture: getNovelsFuture, controller: controller, hasMore: hasMore));
  }
}
