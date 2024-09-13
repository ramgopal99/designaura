import 'package:designaura/src/pages/marketplace/marketplacePage.dart';
import 'package:designaura/src/pages/profile/profilePage.dart';
import 'package:designaura/src/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'src/pages/home/homePage.dart';
import 'package:designaura/src/pages/home/homePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Track the selected index
  late PageController _pageController; // PageController instance

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex); // Initialize PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController when the widget is disposed
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomePage(),
          Marketplacepage(),
          Profilepage(),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
