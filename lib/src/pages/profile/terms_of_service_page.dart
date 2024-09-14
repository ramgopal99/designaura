import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  // Make sure it's a StatelessWidget or StatefulWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile App Terms and Conditions'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Terms introduction
            Text(
              'These Terms and Conditions ("Terms") govern your use of [App Name] ("App"), developed by [Developer\'s Full Legal Name] ("Developer"). By downloading, installing, or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, do not use the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16),
            // Definitions section
            _buildSectionHeader('Definitions'),
            _buildOrderedList([
              '"User" refers to any person who downloads, installs, or uses the App.',
              '"Content" refers to any text, images, video, audio, or other media available through the App.',
            ]),
            SizedBox(height: 16),
            // License section
            _buildSectionHeader('License'),
            Text(
              'Subject to your compliance with these Terms, the Developer grants you a limited, non-exclusive, non-transferable, revocable license to download, install, and use the App for your personal, non-commercial purposes.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16),
            // User conduct section
            _buildSectionHeader('User Conduct'),
            _buildOrderedList([
              'Use the App for any unlawful or fraudulent purposes.',
              'Copy, modify, adapt, or create derivative works of the App or its Content.',
              'Interfere with, disrupt, or overload the App or its underlying infrastructure.',
              'Attempt to gain unauthorized access to the App or any associated systems or networks.',
            ]),
            SizedBox(height: 16),
            // Intellectual Property Rights section
            _buildSectionHeader('Intellectual Property Rights'),
            Text(
              'All rights, title, and interest in and to the App, including its Content and any associated intellectual property rights, are the exclusive property of the Developer and its licensors. You may not reproduce, distribute, or create derivative works of the App or its Content without the express written permission of the Developer.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16),
            // Disclaimer section
            _buildSectionHeader('Disclaimer'),
            Text(
              'THE APP IS PROVIDED "AS IS" AND "AS AVAILABLE," WITHOUT WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build section header
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Helper function to build ordered lists
  Widget _buildOrderedList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        int index = entry.key + 1;
        String item = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$index. ",
                style: TextStyle(fontSize: 16.0),
              ),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
