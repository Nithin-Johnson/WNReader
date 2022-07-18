import 'package:flutter/material.dart';

class novelNameInfo extends StatelessWidget {
  const novelNameInfo({Key? key, required this.novelName}) : super(key: key);

  final String novelName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          novelName,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
