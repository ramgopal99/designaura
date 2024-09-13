import 'dart:async';
import 'package:designaura/main_page.dart';

import '../../core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/colors.dart';

class CustomBottomWidget extends StatefulWidget {
  final PageController pageController;

  const CustomBottomWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _CustomBottomWidgetState createState() => _CustomBottomWidgetState();
}

class _CustomBottomWidgetState extends State<CustomBottomWidget> {
  late Timer _autoScrollTimer;
  final int _pageCount = 3; // Number of pages

  @override
  void initState() {
    super.initState();

    // Start a timer that scrolls the page every 2 seconds
    _autoScrollTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (widget.pageController.hasClients) {
        int currentPage = widget.pageController.page?.toInt() ?? 0;
        int nextPage =
            (currentPage + 1) % _pageCount; // Loop back to first page

        if (currentPage == _pageCount - 1) {
          // If on the last page, scroll back to the first page after a short delay
          Future.delayed(Duration(milliseconds: 500), () {
            widget.pageController.jumpToPage(0);
          });
        } else {
          widget.pageController.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize
          .min, // Ensures the widget takes up minimal vertical space
      children: [
        SmoothPageIndicator(
          controller: widget.pageController,
          count: _pageCount,
          effect: WormEffect(
            dotColor: Colors.grey,
            activeDotColor: Colors.black,
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
        SizedBox(height: 20),
        Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x000000).withOpacity(1),
                  offset: Offset(6, 5),
                  blurRadius: 0,
                  spreadRadius: -1,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: AppColors.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Image.asset(
                      AppAssets
                          .assetsIconsGoogle, // Path to your Google icon asset
                      height: 24,
                      width: 24,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Sign In With Google",
                    style: TextStyle(
                      color: AppColors.tertiaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
