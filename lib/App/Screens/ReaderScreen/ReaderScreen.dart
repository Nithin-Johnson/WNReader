import 'package:WNReader/App/Screens/Services/Chapters/getChapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({Key? key,
    required this.novelUrl,
    required this.chapterUrl,
    required this.sourceID,
  required this.chapterId}) : super(key: key);

  final String novelUrl;
  final String chapterUrl;
  final int sourceID;
  final int chapterId;


  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {

  Future<Map> getChapterData() async {
    return await getChapterAction(widget.sourceID, widget.novelUrl, widget.chapterUrl, widget.chapterId);
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
                return ListView(padding: const EdgeInsets.all(8.0), children: [
                  Column(children: [
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
                    Html(data: snapshot.data['chapterText'],
                      style: {
                        "p" : Style(fontSize: const FontSize(20)),
                      },
                      //tagsList: Html.tags..remove('div'),
                    ),
                  ]),
                ]);
              }
            }));
  }
}
