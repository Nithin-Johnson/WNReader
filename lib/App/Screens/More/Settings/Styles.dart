import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Services/Providers/ThemeProvider.dart';

class Styles extends StatelessWidget {
  const Styles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('About'),
        elevation: 0,
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, child) {
          return ExpansionTile(
            title: Text('System Theme'),
            children: [
              ListTile(
                title: Text('Dark'),
                onTap: () {
                  notifier.dark();
                },
              ),
              ListTile(
                title: Text('Light'),
                onTap: () {
                  notifier.light();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
