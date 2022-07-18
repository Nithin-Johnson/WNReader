import 'package:flutter/material.dart';
import '../../Screens/NovelScreen/NovelScreen.dart';

class getNovelCards extends StatelessWidget {
  const getNovelCards(
      {Key? key, required this.getNovelFuture, required this.controller, required this.hasMore})
      : super(key: key);

  final Future? getNovelFuture;
  final ScrollController controller;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getNovelFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return GridView.builder(
                controller: controller,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1 / 1.5),
                itemCount: snapshot.data['novels'].length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < snapshot.data['novels'].length) {
                    return Card(
                        child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          //width: double.infinity,
                          child: ClipRRect(
                            child: Image.network(snapshot.data['novels'][index]['novelCover'],
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            height: 50,
                            width: 82,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.black,
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.grey.withOpacity(0.0),
                                        Colors.black,
                                      ],
                                      stops: [
                                        0.0,
                                        0.7
                                      ])),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          child: Container(
                            width: 82,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: Center(
                                child: Text(snapshot.data['novels'][index]['novelName'],
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  focusColor: Colors.yellow.withOpacity(0.4),
                                  splashColor: Colors.blue.withOpacity(0.5),
                                  highlightColor: Colors.red.withOpacity(0.3),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NovelScreen(
                                                    novelURL: snapshot
                                                        .data['novels']
                                                    [index]['novelUrl'],
                                                    sourceID: snapshot
                                                        .data['sourceId'])));
                                  },
                                ))),
                      ],
                    ));
                  } else {
                    return hasMore
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                            child: Text(
                              'Reached End',
                              textAlign: TextAlign.center,
                            ),
                          );
                  }
                },
              );
            }
          }),
    );
  }
}
