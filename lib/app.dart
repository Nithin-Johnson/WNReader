import 'package:WNReader/App/BottomNavigation/BottomNavigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'App/Services/Providers/ThemeProvider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context,ThemeProvider notifier,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme! ? ThemeData.dark() : ThemeData.light(),
            home: BottomNavigator(),
          );
        }
    );
  }
}
