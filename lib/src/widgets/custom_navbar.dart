import 'package:flutter/material.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';

class CustomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    final int itemCount = 3; // Number of items in the navbar
    final double itemWidth = MediaQuery.of(context).size.width / itemCount;
    final double topLineHeight = 3.0;
    
    return Stack(
      children: [
        BottomNavigationBar(
          backgroundColor: AppColors.tertiaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.selectedIndex,
          onTap: widget.onItemTapped,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.quaternaryColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: TextStyle(fontSize: 10),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.assetsIconsHome,
                height: 24,
                width: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.assetsIconsMarketplace,
                height: 24,
                width: 24,
              ),
              label: 'MarketPlace',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.assetsIconsProfile,
                height: 24,
                width: 24,
              ),
              label: 'Profile',
            ),
          ],
        ),
        // Top line for the selected item
        Positioned(
          top: 0,
          left: itemWidth * widget.selectedIndex,
          child: Container(
            width: itemWidth,
            height: topLineHeight,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
