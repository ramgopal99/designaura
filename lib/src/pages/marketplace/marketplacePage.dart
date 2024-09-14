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
    'image': AppAssets.assetsImagesAccentChestFree0,
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
    'image': AppAssets.assetsIconsImg,
    'modelUrl': AppAssets.assetsImagesBed,
    'description': 'A modern bed with a sleek frame, designed to offer ultimate comfort and support for a peaceful night’s sleep.'
  },
],

'Recommended for You': [
  {
    'name': 'Table Lamp',
    'image': AppAssets.assetsIconsImg,
    'modelUrl': AppAssets.assetsImagesBedsideTableLamp,
    'description': 'A sleek and modern table lamp that provides warm ambient lighting, perfect for bedside or desk use.'
  },
  {
    'name': 'Lamp',
    'image': AppAssets.assetsImagesIkeaLamp0,
    'modelUrl': AppAssets.assetsImagesIkeaLamp,
    'description': 'A contemporary lamp with a minimalistic design, great for illuminating small spaces while adding a touch of elegance.'
  },
  {
    'name': 'Sofa',
    'image': AppAssets.assetsIconsImg,
    'modelUrl': AppAssets.assetsImagesSofa,
    'description': 'A spacious and cozy sofa with plush cushions, ideal for lounging with family or entertaining guests.'
  },
  {
    'name': 'Stool',
    'image': AppAssets.assetsIconsImg,
    'modelUrl': AppAssets.assetsImagesStool,
    'description': 'A versatile stool that combines comfort and style, perfect as extra seating or a decorative accent in any room.'
  },
],

'New Arrivals': [
  {
    'name': 'Desk',
    'image': AppAssets.assetsImagesSimpleOfficeDeskFree0,
    'modelUrl': AppAssets.assetsImagesSimpleOfficeDeskFree,
    'description': 'A sleek and minimalist office desk with ample workspace, ideal for both home offices and workstations.'
  },
  {
    'name': 'Vintage Chaise Longue',
    'image': AppAssets.assetsIconsImg,
    'modelUrl': AppAssets.assetsImagesVintageChaiseLongue,
    'description': 'A beautifully crafted vintage chaise longue that brings timeless elegance and comfort to any space.'
  },
],

'Seasonal Picks': [
  {
    'name': 'Wooden Flower Stand',
    'image': AppAssets.assetsIconsImg,
    'modelUrl': AppAssets.assetsImagesWoodenFlowerStandFree,
    'description': 'A rustic wooden flower stand that enhances your home’s natural charm, perfect for showcasing plants indoors or outdoors.'
  },
  {
    'name': 'TV Entertainment Center',
    'image': AppAssets.assetsIconsImg,
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
        title: Text('Marketplace',style: TextStyle( 
            fontSize: 21, 
            fontWeight: FontWeight.bold, 
          ), ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: filteredProducts.map((entry) {
          return CategorySection(
            title: entry.key,
            products: entry.value,
          );
        }).toList(),
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Container(
          height: 200, // Adjust the height as needed
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (ctx, i) => CategoryItem(
              name: products[i]['name']!,
              imageUrl: products[i]['image']!,
              modelUrl: products[i]['modelUrl']!,
              description: products[i]['description']!, // Pass unique description
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
  final String description; // Add description parameter

  CategoryItem({
    required this.name,
    required this.imageUrl,
    required this.modelUrl,
    required this.description, // Add description parameter
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
              modelUrl: modelUrl, // Pass model URL
              description: description, // Pass description
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: 150, // Adjust width as needed
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
