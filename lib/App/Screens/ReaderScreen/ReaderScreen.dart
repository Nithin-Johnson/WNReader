import 'package:WNReader/App/Screens/Services/Chapters/getChapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../Database/Queries/ChapterQueries.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen(
      {Key? key,
      required this.novel,
      required this.chapterUrl,
      required this.chapterId})
      : super(key: key);

  final novel;
  final String chapterUrl;
  final int chapterId;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  Future<Map> getChapterData() async {
    return await getChapterAction(widget.novel['sourceId'],
        widget.novel['novelUrl'], widget.chapterUrl, widget.chapterId);
  }
  Map chapter = {};
  getNxtChapter() async{
    chapter = await getNextChapter(widget.novel["novelId"], widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: getChapterData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        snapshot.data['chapterName'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),
                    Html(
                      data: snapshot.data['chapterText'],
                      style: {
                        "p": Style(fontSize: const FontSize(20)),
                      },
                    ),
                    const Divider(),
                    TextButton(onPressed: () async{
                      await getNxtChapter();
                      debugPrint(chapter['chapterUrl']);
                      debugPrint(chapter['chapterId'].toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => ReaderScreen(novel: widget.novel, chapterUrl: chapter['chapterUrl'], chapterId: chapter['chapterId']),
                        ),                         //if you want to disable back feature set to false
                      );
                    }, child: Text("Next Chapter"))
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
