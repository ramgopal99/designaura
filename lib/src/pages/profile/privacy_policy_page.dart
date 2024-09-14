import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review app\'s Privacy Policy'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'It\'s important that you understand what information app collects, uses and how you can control it. We explain it in detail in our updated app\'s Privacy Policy and you can review the key points below.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16),
            Text(
              'Why does this app use your data?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'To give you a customized in-app experience, improve our services, understand how users use app, show ads, and more.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16),
            Text(
              'Some examples of app collects and uses are:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16),
            _buildPrivacySection(
              title: 'Your app information & content',
              description:
                  'This may include any information you share with us, for example: your saved home or work address and photos you upload to the app map.',
            ),
            SizedBox(height: 16),
            _buildPrivacySection(
              title: 'Location & activity',
              description:
                  'This may include your route details, places you searched for and device information.',
            ),
            SizedBox(height: 16),
            _buildPrivacySection(
              title: 'Voice & audio activity',
              description:
                  'This may include a recording of your voice when you choose to use voice commands or when you create custom directions.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySection(
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}