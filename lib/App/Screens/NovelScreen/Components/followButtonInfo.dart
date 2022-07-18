import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Services/Novel/getNovel.dart';

class followButtonInfo extends HookWidget{
  const followButtonInfo({Key? key, required this.novel}) : super(key: key);

  final novel;
  @override
  Widget build(BuildContext context) {
    final followed = useState(novel['followed']);
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              followed.value!= 0
                  ? Column(
                children: [
                  IconButton(
                      onPressed: () {
                          unfollowNovelAction(novel);
                          followed.value = 0;
                      },
                      icon: Icon(Icons.favorite)),
                  Text('In library')
                ],
              )
                  : Column(
                children: [
                  IconButton(
                      onPressed: () {
                          followNovelAction(novel);
                          followed.value = 1;
                      },
                      icon: Icon(Icons.favorite_border)),
                  Text('Add to library')
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        Uri url = Uri.parse(novel['sourceUrl']);
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      },
                      icon: Icon(Icons.open_in_browser)),
                  Text('WebView')
                ],
              )
            ],
          ),
        ));
  }
}

