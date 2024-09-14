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
        title: const Text( 
          'Profile', 
          style: TextStyle( 
            fontSize: 21, 
            fontWeight: FontWeight.bold, 
          ), 
        ), 
        automaticallyImplyLeading: false,
      ), 
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),  // Uniform padding for the entire page
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [ 
              const Text( 
                'John Doe', // Change this to dynamic username if needed 
                style: TextStyle( 
                  fontSize: 24, 
                  fontWeight: FontWeight.bold, 
                ), 
              ), 
              const SizedBox(height: 16),  // Add some spacing
              const Divider(), 
              
              // Settings Section 
              ListTile( 
                leading: const Icon(Icons.person), 
                title: const Text('My Profile'), 
                trailing: const Icon(Icons.arrow_forward_ios), 
                onTap: () { 
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => MyProfilePage()),
                  );
                }, 
              ), 
              
              ListTile( 
                leading: const Icon(Icons.recommend), 
                title: const Text('Feedback'), 
                trailing: const Icon(Icons.arrow_forward_ios), 
                onTap: () { 
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => FeedbackPage()),
                  );
                }, 
              ), 
              
              const Divider(), 
              
              // Legal Information 
              ListTile( 
                leading: const Icon(Icons.file_copy), 
                title: const Text('Terms of Service'), 
                trailing: const Icon(Icons.arrow_forward_ios), 
                onTap: () { 
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => TermsOfServicePage()),
                  );
                }, 
              ), 
              ListTile( 
                leading: const Icon(Icons.privacy_tip), 
                title: const Text('Privacy Policy'), 
                trailing: const Icon(Icons.arrow_forward_ios), 
                onTap: () { 
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                  );
                }, 
              ), 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 
}
