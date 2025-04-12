import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/widgets/build_food_tile.dart';
import 'package:food_app/widgets/category_icon.dart';
import 'package:food_app/widgets/build_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showVegOnly = false;
  bool showNonVegOnly = false;

  final List<FoodItem> foodItems = [
    FoodItem(
        id: 1,
        name: 'Margherita Pizza',
        price: 150,
        image: 'assets/images/pizza.jpg',
        isVeg: true,
        foodType: 'food'),
    FoodItem(
        id: 2,
        name: 'Veg Meals',
        price: 180,
        image: 'assets/images/veg_meals.jpg',
        isVeg: true,
        foodType: 'food'),
    FoodItem(
        id: 3,
        name: 'French Fries',
        price: 80,
        image: 'assets/images/french_fries.jpg',
        isVeg: true,
        foodType: 'snacks'),
    FoodItem(
        id: 4,
        name: 'Apple Milkshake',
        price: 50,
        image: 'assets/images/apple.jpg',
        isVeg: true,
        foodType: 'beverages'),
    FoodItem(
        id: 4,
        name: 'Non Veg Meals',
        price: 50,
        image: 'assets/images/non_veg_meals.jpg',
        isVeg: false,
        foodType: 'food'),
    FoodItem(
        id: 4,
        name: 'Shawarma',
        price: 50,
        image: 'assets/images/shawarma.jpg',
        isVeg: false,
        foodType: 'food'),
    FoodItem(
        id: 4,
        name: 'Sandwich',
        price: 50,
        image: 'assets/images/sandwich.jpg',
        isVeg: true,
        foodType: 'snacks'),
    FoodItem(
        id: 4,
        name: 'Bread Omlet',
        price: 50,
        image: 'assets/images/bread_omlet.jpg',
        isVeg: false,
        foodType: 'snacks'),
    FoodItem(
        id: 4,
        name: 'Burger',
        price: 50,
        image: 'assets/images/burger.jpg',
        isVeg: false,
        foodType: 'food'),
  ];

  @override
  Widget build(BuildContext context) {
    List<FoodItem> filteredItems = foodItems.where((item) {
      if (showVegOnly) return item.isVeg;
      if (showNonVegOnly) return !item.isVeg;
      return true;
    }).toList();

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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilterChip(
                      label: const Text("Veg"),
                      selected: showVegOnly,
                      onSelected: (val) {
                        setState(() {
                          showVegOnly = val;
                          showNonVegOnly = false;
                        });
                      },
                      selectedColor: Colors.green.withOpacity(0.2),
                    ),
                    const SizedBox(width: 10),
                    FilterChip(
                      label: const Text("Non-Veg"),
                      selected: showNonVegOnly,
                      onSelected: (val) {
                        setState(() {
                          showNonVegOnly = val;
                          showVegOnly = false;
                        });
                      },
                      selectedColor: Colors.red.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        buildBanner('30% OFF\nUSE BP55', Colors.orange,
                            'assets/images/burger.jpg'),
                        buildBanner('10% OFF\nTRY IT NOW', Colors.blue,
                            'assets/images/pizza.jpg'),
                        buildBanner('50% OFF\nUSE 302406', Colors.deepPurple,
                            'assets/images/apple.jpg'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        Text('Explore Menu',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ...filteredItems
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
                CategoryIcon(icon: Icons.local_drink, label: "Juice"),
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
