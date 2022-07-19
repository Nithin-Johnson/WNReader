import 'package:flutter/material.dart';

class novelCoverInfo extends StatelessWidget {
  const novelCoverInfo({Key? key, required this.novelCover}) : super(key: key);

  final String novelCover;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8)),
          height: size.height - 600,
          width: size.width - 215,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(novelCover, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
