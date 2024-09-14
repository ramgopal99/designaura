import 'package:designaura/core/constants/assets.dart';
import 'package:flutter/material.dart';
import 'product_detail_page.dart'; // Import the ProductDetailPage

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final Map<String, List<Map<String, String>>> categoryProducts = {
    'Trending Now': [
      {
        'name': 'Accent Chest',
        'image': AppAssets.assetsImagesAccentchest0,
        'modelUrl': AppAssets.assetsImagesAccentChestFree,
        'description': 'A stylish accent chest that adds both storage and charm to any room, featuring a modern design with intricate detailing.'
      },
      {
        'name': 'Arm Chair',
        'image': AppAssets.assetsImagesArmchair0,
        'modelUrl': AppAssets.assetsImagesArmchair,
        'description': 'A comfortable and luxurious armchair perfect for relaxing or adding a touch of sophistication to your living space.'
      },
      {
        'name': 'Bed',
        'image': AppAssets.assetsImagesBed0,
        'modelUrl': AppAssets.assetsImagesBed,
        'description': 'A modern bed with a sleek frame, designed to offer ultimate comfort and support for a peaceful night’s sleep.'
      },
    ],
    'Recommended for You': [
      {
        'name': 'Table Lamp',
        'image': AppAssets.assetsImagesTll0,
        'modelUrl': AppAssets.assetsImagesBedsideTableLamp,
        'description': 'A sleek and modern table lamp that provides warm ambient lighting, perfect for bedside or desk use.'
      },
      {
        'name': 'Lamp',
        'image': AppAssets.assetsImagesLamp0,
        'modelUrl': AppAssets.assetsImagesIkeaLamp,
        'description': 'A contemporary lamp with a minimalistic design, great for illuminating small spaces while adding a touch of elegance.'
      },
      {
        'name': 'Sofa',
        'image': AppAssets.assetsImagesSofa0,
        'modelUrl': AppAssets.assetsImagesSofa,
        'description': 'A spacious and cozy sofa with plush cushions, ideal for lounging with family or entertaining guests.'
      },
      {
        'name': 'Stool',
        'image': AppAssets.assetsImagesStool0,
        'modelUrl': AppAssets.assetsImagesStool,
        'description': 'A versatile stool that combines comfort and style, perfect as extra seating or a decorative accent in any room.'
      },
    ],
    'New Arrivals': [
      {
        'name': 'Desk',
        'image': AppAssets.assetsImagesDesk0,
        'modelUrl': AppAssets.assetsImagesSimpleOfficeDeskFree,
        'description': 'A sleek and minimalist office desk with ample workspace, ideal for both home offices and workstations.'
      },
      {
        'name': 'Vintage Chaise Longue',
        'image': AppAssets.assetsImagesVcl0,
        'modelUrl': AppAssets.assetsImagesVintageChaiseLongue,
        'description': 'A beautifully crafted vintage chaise longue that brings timeless elegance and comfort to any space.'
      },
    ],
    'Seasonal Picks': [
      {
        'name': 'Wooden Flower Stand',
        'image': AppAssets.assetsImagesWfs0,
        'modelUrl': AppAssets.assetsImagesWoodenFlowerStandFree,
        'description': 'A rustic wooden flower stand that enhances your home’s natural charm, perfect for showcasing plants indoors or outdoors.'
      },
      {
        'name': 'TV Entertainment Center',
        'image': AppAssets.assetsImagesTv0,
        'modelUrl': AppAssets.assetsImagesModernEntertainmentCenterFree,
        'description': 'A modern entertainment center with ample storage space, designed to hold all your media equipment in style.'
      },
    ],
  };

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter products based on search query
    final filteredProducts = categoryProducts.entries
        .where((entry) => entry.value
            .any((product) => product['name']!.toLowerCase().contains(searchQuery.toLowerCase())))
        .map((entry) {
          final products = entry.value
              .where((product) => product['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();
          return MapEntry(entry.key, products);
        })
        .where((entry) => entry.value.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Marketplace',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                  
                ),
                enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black, width: 1.5), // Black border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.black, width: 2.0), // Darker black border on focus
      ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: filteredProducts.map((entry) {
                return CategorySection(
                  title: entry.key,
                  products: entry.value,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> products;

  CategorySection({required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        Container(
          height: 250, // Adjust the height as needed
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (ctx, i) => CategoryItem(
              name: products[i]['name']!,
              imageUrl: products[i]['image']!,
              modelUrl: products[i]['modelUrl']!,
              description: products[i]['description']!,
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String modelUrl;
  final String description;

  CategoryItem({
    required this.name,
    required this.imageUrl,
    required this.modelUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              name: name,
              imageUrl: imageUrl,
              modelUrl: modelUrl,
              description: description,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 150,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap for details',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
