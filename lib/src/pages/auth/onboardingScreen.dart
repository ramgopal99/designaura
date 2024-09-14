import 'package:designaura/core/constants/assets.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../widgets/onbording_custom_buttom.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {});
            },
            children: [
             buildPage(
  color: AppColors.backgroundColor,
  title: 'Welcome to Aura',
  subtitle: 'Transform your space with cutting-edge 3D AR modeling and personalized design suggestions.',
  imagePath: AppAssets.assetsIconsOb1,
),
buildPage(
  color: AppColors.backgroundColor,
  title: 'Smart Design Suggestions',
  subtitle: 'Get creative design ideas and product recommendations from our intelligent chatbot.',
  imagePath: AppAssets.assetsIconsOb2,
),
buildPage(
  color: AppColors.backgroundColor,
  title: 'Explore and Shop',
  subtitle: 'Browse stylish decor items, view detailed descriptions, and use AR to try before you buy.',
  imagePath: AppAssets.assetsIconsOb3,
),

            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: CustomBottomWidget(
              pageController: _pageController,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required Color color,
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return Container(
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 20), // Added padding for better alignment
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 350, // Adjust width as needed
            height: 350, // Adjust height as needed
            fit: BoxFit.cover, // Adjust image fit
          ),
          SizedBox(height: 30), // Adjust spacing between image and title
          Text(
            title,
            style: TextStyle(
              fontSize: 24, // Adjust font size as needed
              color: AppColors.quaternaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15), // Adjust spacing between title and subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30), // Adjust horizontal padding
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 16, // Adjust font size as needed
                color: AppColors.quaternaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
