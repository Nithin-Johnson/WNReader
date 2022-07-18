import 'package:WNReader/App/Screens/Services/Chapters/downloadChaptersAction.dart';
import 'package:flutter/material.dart';

class appBarActionButtons extends StatefulWidget {
  const appBarActionButtons({Key? key, required this.novel}) : super(key: key);

  final Future novel;

  @override
  State<appBarActionButtons> createState() => _appBarActionButtonsState();
}

class _appBarActionButtonsState extends State<appBarActionButtons> {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(Icons.download_outlined, color: Theme.of(context).iconTheme.color,),
        offset: Offset(0, 50),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 1,
              child: Text("Unread"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("All"),
            ),
          ];
        },
      onSelected: (value) async {
          value==1 ? downloadUnreadChaptersAction(await widget.novel) : downloadAllChaptersAction(await widget.novel);
      },

    );
  }
}
