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
                title: 'Welcome fg',
                subtitle: 'This is the first page of the onboarding.',
                image: Icons.ac_unit,
              ),
              buildPage(
                color: AppColors.backgroundColor,
                title: 'Discover',
                subtitle: 'Discover new features and capabilities.',
                image: Icons.lightbulb_outline,
              ),
              buildPage(
                color: AppColors.backgroundColor,
                title: 'Get Started',
                subtitle: 'Let\'s get started with our application.',
                image: Icons.start,
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
    required IconData image,
  }) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 120, color: AppColors.quaternaryColor),
          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 28,
              color: AppColors.quaternaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
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
