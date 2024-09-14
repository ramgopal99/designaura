import 'package:designaura/src/pages/marketplace/shop_chat.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart'; // Import model_viewer_plus

class ProductDetailPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String modelUrl; // Add model URL
  final String description;

  ProductDetailPage({
    required this.name,
    required this.imageUrl,
    required this.modelUrl, // Add model URL parameter
    required this.description,
  });

  void _navigateToChatPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopChatPage(
          initialMessage: 'give buy link of $name', // Correct named parameter
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26, // Shadow color
                    offset: Offset(0, 4), // Shadow position
                    blurRadius: 8.0, // Shadow blur radius
                  ),
                ],
              ),
              child: ModelViewer(
                src: modelUrl,
                alt: name,
                autoRotate: true,
                ar: true,
                arModes: ['scene-viewer'],
                cameraControls: true,
                // Customize other properties as needed
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12, // Shadow color
                    offset: Offset(0, 2), // Shadow position
                    blurRadius: 6.0, // Shadow blur radius
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24, // Adjust size as needed
                          color: Colors.black87, // Adjust color as needed
                          letterSpacing: 1.2, // Add spacing between letters
                        ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16, // Adjust size as needed
                          color: Colors.black54, // Adjust color as needed
                          letterSpacing: 0.5, // Add spacing between letters
                        ),
                  ),
                ],
              ),
            ),
            Spacer(), // Pushes the button to the bottom
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => _navigateToChatPage(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Chat With Our Bot to get best Buy link', // Button text
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
