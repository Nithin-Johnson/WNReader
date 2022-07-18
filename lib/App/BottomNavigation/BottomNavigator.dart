import 'package:WNReader/App/Screens/Browse/Browse.dart';
import 'package:WNReader/App/Screens/Library/Library.dart';
import 'package:WNReader/App/Screens/More/More.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomNavigator extends HookWidget {
  final List screens = [const Library(),Browse(),const More()];

  BottomNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return Scaffold(
      body: screens[selectedIndex.value],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          height: 60,
          selectedIndex: selectedIndex.value,
          onDestinationSelected: (index) => selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.collections_bookmark_outlined),
              selectedIcon: Icon(Icons.collections_bookmark),
              label: 'Library',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Browse',
            ),
            NavigationDestination(
              icon: Icon(Icons.more_horiz),
              selectedIcon: Icon(Icons.more_horiz),
              label: 'More',
            )
          ],
        ),
      ),
    );
  }
}
