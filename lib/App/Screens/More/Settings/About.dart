import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri githubPage =  Uri.parse('https://github.com/Nithin-Johnson/wnreader');
final Uri githubReleasesPage = Uri.parse('https://github.com/Nithin-Johnson/WNReader/releases');

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            title: Text('Version'),
            subtitle: Text('0.01',
              style: TextStyle(fontSize: 10),
            ),
          ),
          ListTile(
            title: Text('Check for app update'),
            onTap: () {
              _launchUrl(githubReleasesPage);
            },
          ),
          Divider(),
          ListTile(
              title: Text('GitHub'),
              subtitle: Text('https://github.com/Nithin-Johnson/wnreader',
                style: TextStyle(fontSize: 10),
              ),
              onTap: () {
                _launchUrl(githubPage);
              }
          )
        ],
      ),
    );
  }
}

void _launchUrl(Uri url)async {
  await canLaunchUrl(url)
      ? await launchUrl(url)
      :throw 'Could not Open';
}

