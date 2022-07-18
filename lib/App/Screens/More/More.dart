import 'package:flutter/material.dart';

import 'Settings/About.dart';
import 'Settings/Settings.dart';
import 'Settings/Styles.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              child: Image.asset('assets/icons/Icon.png'),
              width: MediaQuery.of(context).size.width,
              height: 120,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Styles'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Styles()));
            },

          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Settings()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> About()));
            },
          )
        ],
      ),
    );
  }
}
