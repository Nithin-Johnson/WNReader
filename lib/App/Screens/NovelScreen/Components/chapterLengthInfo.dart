import 'package:flutter/material.dart';

class chapterLengthInfo extends StatelessWidget {
  const chapterLengthInfo({Key? key, required this.chapters}) : super(key: key);

  final chapters;

  @override
  Widget build(BuildContext context) {

    return Text(
      'Chapters: ' +
          chapters.length.toString(),
      textAlign: TextAlign.left,
    );
  }
}
