import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/widgets/build_food_tile.dart';
import 'package:food_app/widgets/category_icon.dart';
import 'package:food_app/widgets/build_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FoodItem> foodItems = [
      FoodItem(
          id: 1,
          name: 'Margherita Pizza',
          price: 150,
          image: 'https://i.imgur.com/Z9qG1Da.png'),
      FoodItem(
          id: 2,
          name: 'Quick Bites',
          price: 80,
          image: 'https://i.imgur.com/3jLPB46.png'),
      FoodItem(
          id: 3,
          name: 'Gulab Jamun',
          price: 80,
          image: 'https://i.imgur.com/LrGp2Av.png'),
      FoodItem(
          id: 1,
          name: 'Margherita Pizza',
          price: 150,
          image: 'https://i.imgur.com/Z9qG1Da.png'),
      FoodItem(
          id: 1,
          name: 'Margherita Pizza',
          price: 150,
          image: 'https://i.imgur.com/Z9qG1Da.png'),
      FoodItem(
          id: 1,
          name: 'Margherita Pizza',
          price: 150,
          image: 'https://i.imgur.com/Z9qG1Da.png'),
      FoodItem(
          id: 1,
          name: 'Margherita Pizza',
          price: 150,
          image: 'https://i.imgur.com/Z9qG1Da.png'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: const Color.fromARGB(255, 231, 214, 251),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Chennai',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFF4e29ac),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        buildBanner('30% OFF\nUP TO 10.175', Colors.orange),
                        buildBanner('30% OFF\nTRY IT NOW', Colors.blue),
                        buildBanner('50% OFF\nUSE 302406', Colors.deepPurple),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Explore Menu',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ...foodItems
                      .map((item) => buildFoodTile(context, item))
                      .toList(),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 231, 214, 251),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for restaurants or dishes',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CategoryIcon(icon: Icons.fastfood, label: "Food"),
                CategoryIcon(icon: Icons.local_drink, label: "Beverages"),
                CategoryIcon(icon: Icons.local_offer, label: "Offers"),
                CategoryIcon(icon: Icons.favorite, label: "Favourites"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 160;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
