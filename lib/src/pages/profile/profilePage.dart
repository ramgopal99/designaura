import 'package:designaura/core/constants/assets.dart'; // Ensure the correct path to assets
import 'package:flutter/material.dart';
import 'my_profile_page.dart';
import 'feedback_page.dart';
import 'terms_of_service_page.dart';
import 'privacy_policy_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
             automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Info Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(AppAssets.assetsIconsProfile), // Use your asset path
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sonu', // Dynamic username
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'sonu.bagh@aren.com', // Dynamic email
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              
              const Divider(),
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              
              // Cards for Profile and Feedback
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.teal),
                  title: const Text('My Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilePage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.recommend, color: Colors.teal),
                  title: const Text('Feedback'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                ),
              ),
              
              const Divider(),
              
              // Legal Information
              const Text(
                'Legal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              
              // Cards for Legal Pages
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.file_copy, color: Colors.teal),
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsOfServicePage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              
              Card(
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.teal),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}