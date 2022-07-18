import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class novelSummaryInfo extends HookWidget {
  novelSummaryInfo({Key? key, required this.novelSummary,}) : super(key: key);

  final String novelSummary;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Text(
                novelSummary,
                maxLines: isExpanded.value ? 1000 : 4,
              ),
              InkWell(
                onTap: () {
                    isExpanded.value = !isExpanded.value;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isExpanded.value
                        ? Text(
                      "Show Less",
                      style:
                      TextStyle(color: Colors.blue),
                    )
                        : Text(
                      "Show More",
                      style:
                      TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
