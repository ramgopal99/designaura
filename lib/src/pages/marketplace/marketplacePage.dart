// ignore: file_names
import 'package:designaura/core/constants/assets.dart';
import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Electronics', 'image': Assets.assetsIconsImg},
    {'title': 'Clothing', 'image': Assets.assetsIconsImg},
    {'title': 'Home Appliances', 'image':Assets.assetsIconsImg },
    {'title': 'Books', 'image':Assets.assetsIconsImg },
    {'title': 'Furniture', 'image':Assets.assetsIconsImg },
    {'title': 'Sports', 'image':Assets.assetsIconsImg },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (ctx, i) => CategoryItem(
          categories[i]['title']!,
          categories[i]['image']!,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  CategoryItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add navigation to the category products here
      },
      child: GridTile(
        child: Image.asset(imageUrl, fit: BoxFit.cover),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
