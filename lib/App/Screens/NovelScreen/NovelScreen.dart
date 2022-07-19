import 'package:WNReader/App/Screens/NovelScreen/Components/appBarActionButtons.dart';
import 'package:WNReader/App/Screens/NovelScreen/Components/chapterLengthInfo.dart';
import 'package:WNReader/App/Screens/NovelScreen/Components/chapterListInfo.dart';
import 'package:WNReader/App/Screens/NovelScreen/Components/followButtonInfo.dart';
import 'package:WNReader/App/Screens/NovelScreen/Components/novelNameInfo.dart';
import 'package:WNReader/App/Screens/NovelScreen/Components/novelSummaryInfo.dart';
import 'package:WNReader/App/Screens/Services/Novel/getNovel.dart';
import 'package:flutter/material.dart';
import '../Services/Novel/getNovel.dart';
import 'Components/novelCoverInfo.dart';

class NovelScreen extends StatefulWidget {
  const NovelScreen({Key? key, required this.novelURL, required this.sourceID})
      : super(key: key);

  final String novelURL;
  final int sourceID;

  @override
  State<NovelScreen> createState() => _NovelScreenState();
}

class _NovelScreenState extends State<NovelScreen> {
  Future? novel;

  @override
  void initState() {
    super.initState();
    novel = getNovelAction(widget.sourceID, widget.novelURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            )),
        actions: [
          appBarActionButtons(
            novel: novel!,
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: novel,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return LinearProgressIndicator();
            } else {
              return ListView(
                children: [
                  Column(
                    children: [
                      novelCoverInfo(novelCover: snapshot.data['novelCover']),
                      novelNameInfo(novelName: snapshot.data['novelName']),
                      followButtonInfo(novel: snapshot.data),
                      Divider(),
                      novelSummaryInfo(
                          novelSummary: snapshot.data['novelSummary']),
                      Divider(),
                      chapterLengthInfo(chapters: snapshot.data['chapters']),
                      Divider(),
                      chapterListInfo(novel: snapshot.data)
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
