import 'package:WNReader/App/Sources/sourceManager.dart';
import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  Browse({Key? key}) : super(key: key);

  final int count = sourceList.length;
  final List sourceDetail = sourceDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: ((BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                  sourceDetails[index]["icon"],

                ),
              ),
              title: Text(
                sourceDetails[index]["name"],
              ),
              trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => sourceList[index],
                      ),
                    );
                  },
                  child: Text('Latest')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sourceList[index],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
