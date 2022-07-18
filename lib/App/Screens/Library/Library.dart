import 'package:WNReader/App/Screens/Services/Novel/getNovel.dart';
import 'package:flutter/material.dart';
import '../NovelScreen/NovelScreen.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  Future getLibraryNovelsFuture() async {
    return await getLibraryNovelsAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Library'),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
          elevation: 0,
        ),
        body: FutureBuilder(
            future: getLibraryNovelsFuture(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1 / 1.5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          //width: double.infinity,
                          child: ClipRRect(
                            child: Image.network(
                                snapshot.data[index]['novelCover'],
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                child: Text(snapshot.data[index]['novelName'],
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
                                        builder: (context) => NovelScreen(
                                          novelURL: snapshot.data[index]
                                              ['novelUrl'],
                                          sourceID: snapshot.data[index]
                                              ['sourceId'],
                                        ),
                                      ),
                                    ).then((_) {
                                      setState(() {});
                                    });
                                  },
                                ))),
                      ],
                    ));
                  },
                );
              }
            }));
  }
}
