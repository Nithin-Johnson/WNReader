import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Settings'),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.grid_view_outlined),
            title: Text('View'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.book_rounded),
            title: Text('Reader'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.download_sharp),
            title: Text('Download'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Update'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Advanced'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
