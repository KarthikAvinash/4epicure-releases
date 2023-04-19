import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final List<String> quotes = [
    "The only thing better than a good recipe is sharing it.",
    "Food is not just eating energy. It's an experience.",
    "Cooking is like love. It should be entered into with abandon or not at all.",
    "People who love to eat are always the best people."
  ];
  _launchURL(url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meet Our Team',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount:
                    4, // change this to the number of team members you have
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 500, // set the desired height here
                    child: buildTeamMember('John Doe', '21bcs052@iiitdwd.ac.in',
                        'assets/yt_logo_dark.png', "https://www.linkedin.com/in/karthik-avinash-04b51022b/"),
                  );
                },
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Random Recipe Quotes',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              quotes[DateTime.now().millisecondsSinceEpoch % quotes.length],
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamMember(
      String name, String email, String imagePath, String linkedInLink) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 120.0,
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: (){
              _launchURL(email);
            },
            child: Text(
              email,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {
              _launchURL(linkedInLink);
            },
            child: Text(
              linkedInLink,
              style: TextStyle(fontSize: 16.0, color: Colors.blue,),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
