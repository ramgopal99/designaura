import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        ' Profile Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buildBold2 = buildBold();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and User Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/profile_pic.png'), // Placeholder image
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe', // Change this to dynamic username
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),

            // Mood Tracking Section
            ListTile(
              leading: Icon(Icons.mood),
              title: Text('Current Mood'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to mood tracking screen
              },
            ),

            // Chat History
            ListTile(
              leading: Icon(Icons.chat_bubble_outline),
              title: Text('Chat History'),
              subtitle: Text('Review your chat sessions'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to chat history screen
              },
            ),

            // Recommendations
            ListTile(
              leading: Icon(Icons.recommend),
              title: Text('Recommendations'),
              subtitle: Text('Music & Movie Suggestions'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to recommendations section
              },
            ),
            Divider(),

            // Settings Section
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to profile settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Account Settings'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to account settings screen
              },
            ),
            Divider(),

            // Legal Information
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text('Terms of Service'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Terms of Service
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Privacy Policy
              },
            ),
          ],
        ),
      ),
    );
  }

  FontWeight buildBold() => FontWeight.bold;
}
