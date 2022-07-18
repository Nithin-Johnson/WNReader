import 'package:WNReader/App/Services/Providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../ReaderScreen/ReaderScreen.dart';

class chapterListInfo extends HookWidget{
  const chapterListInfo({Key? key, required this.novel}) : super(key: key);

  final novel;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: GridView.builder(
        padding: EdgeInsets.only(left: 10, right: 10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: novel['chapters'].length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: novel['chapters'][index]
              ['downloaded']==1 ? Colors.blue : Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minVerticalPadding: 0,
              title: Center(
                child: Text(
                  novel['chapters'][index]
                  ['chapterName'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReaderScreen(
                      novelUrl: novel['novelUrl'],
                      chapterUrl: novel['chapters']
                      [index]['chapterUrl'],
                      sourceID: novel['sourceId'],
                      chapterId: novel['chapters']
                      [index]['chapterId'],
                    ),
                  ),
                );
              },
              onLongPress: (){},
            ),
          );
        },
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2 / 0.5),
      ),
    );
  }
}
