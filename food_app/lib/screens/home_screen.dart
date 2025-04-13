import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/widgets/build_food_tile.dart';
import 'package:food_app/widgets/category_icon.dart';
import 'package:food_app/widgets/build_banner.dart';
import 'package:food_app/widgets/empty_favourites.dart';
import 'package:food_app/widgets/offer_card.dart';
import 'package:food_app/widgets/veg_non_veg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showVegOnly = false;
  bool showNonVegOnly = false;
  String selectedCategory = 'All';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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
        price: 100,
        image: 'assets/images/veg_meals.jpg',
        isVeg: true,
        foodType: 'food'),
    FoodItem(
        id: 3,
        name: 'French Fries',
        price: 50,
        image: 'assets/images/french_fries.jpg',
        isVeg: true,
        foodType: 'snacks'),
    FoodItem(
        id: 4,
        name: 'Apple Milkshake',
        price: 40,
        image: 'assets/images/apple.jpg',
        isVeg: true,
        foodType: 'beverages'),
    FoodItem(
        id: 5,
        name: 'Non Veg Meals',
        price: 120,
        image: 'assets/images/non_veg_meals.jpg',
        isVeg: false,
        foodType: 'food'),
    FoodItem(
        id: 6,
        name: 'Shawarma',
        price: 90,
        image: 'assets/images/shawarma.jpg',
        isVeg: false,
        foodType: 'food'),
    FoodItem(
        id: 7,
        name: 'Sandwich',
        price: 50,
        image: 'assets/images/sandwich.jpg',
        isVeg: true,
        foodType: 'snacks'),
    FoodItem(
        id: 8,
        name: 'Bread Omlet',
        price: 50,
        image: 'assets/images/bread_omlet.jpg',
        isVeg: false,
        foodType: 'snacks'),
    FoodItem(
        id: 9,
        name: 'Burger',
        price: 80,
        image: 'assets/images/burger.jpg',
        isVeg: false,
        foodType: 'food'),
    FoodItem(
        id: 10,
        name: 'Butter Fruit Shake',
        price: 60,
        image: 'assets/images/butter_fruit.jpg',
        isVeg: true,
        foodType: 'beverages'),
    FoodItem(
        id: 11,
        name: 'Banana Shake',
        price: 40,
        image: 'assets/images/banana.jpg',
        isVeg: true,
        foodType: 'beverages'),
  ];

  final ScrollController _bannerScrollController = ScrollController();
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _bannerScrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    const duration = Duration(seconds: 3);
    _autoScrollTimer = Timer.periodic(duration, (_) {
      if (_bannerScrollController.hasClients) {
        final maxScroll = _bannerScrollController.position.maxScrollExtent;
        final current = _bannerScrollController.offset;
        final next = (current + 300 >= maxScroll) ? 0.0 : current + 300;

        _bannerScrollController.animateTo(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  List<FoodItem> get filteredItems {
    return foodItems.where((item) {
      final matchesSearch =
          item.name.toLowerCase().contains(searchQuery.toLowerCase());
      if (!matchesSearch) return false;

      if (selectedCategory == 'favourites' && !item.isFavourite) return false;
      if (selectedCategory == 'food' &&
          item.foodType != 'food' &&
          item.foodType != 'snacks') return false;
      if (selectedCategory == 'beverages' && item.foodType != 'beverages')
        return false;
      if (selectedCategory == 'offers') return true;
      if (showVegOnly && !item.isVeg) return false;
      if (showNonVegOnly && item.isVeg) return false;

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var _title = "";
    if (selectedCategory == "food") {
      _title = "Foods and Snacks";
    } else if (selectedCategory == "beverages") {
      _title = "Juices and Milkshakes";
    } else if (selectedCategory == "favourites") {
      _title = "Your Favourites";
    } else {
      _title = "Explore Menu";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Top bar
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              delegate: _StickyHeaderDelegate(
                controller: _searchController,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
            ),
            // Banners or Offers
            SliverToBoxAdapter(
              child: selectedCategory == 'All'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          controller: _bannerScrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            buildBanner('30% OFF\nUSE BP55', Colors.orange,
                                'assets/images/burger.jpg'),
                            buildBanner('10% OFF\nTRY IT NOW', Colors.blue,
                                'assets/images/pizza.jpg'),
                            buildBanner('50% OFF\nUSE 302406',
                                Colors.deepPurple, 'assets/images/apple.jpg'),
                          ],
                        ),
                      ),
                    )
                  : selectedCategory == 'offers'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Column(
                            children: [
                              OfferCard(
                                title: "30% OFF",
                                subtitle: "Use Code BP55 on all burgers",
                                imagePath: 'assets/images/burger.jpg',
                                gradientColors: [
                                  Colors.orange,
                                  Colors.deepOrange
                                ],
                                onTap: () =>
                                    setState(() => selectedCategory = 'All'),
                              ),
                              const SizedBox(height: 16),
                              OfferCard(
                                title: "10% OFF",
                                subtitle: "Pizza Deals just for you",
                                imagePath: 'assets/images/pizza.jpg',
                                gradientColors: [
                                  Colors.blueAccent,
                                  Colors.indigo
                                ],
                                onTap: () =>
                                    setState(() => selectedCategory = 'All'),
                              ),
                              const SizedBox(height: 16),
                              OfferCard(
                                title: "50% OFF",
                                subtitle: "Milkshakes Half Price Today",
                                imagePath: 'assets/images/apple.jpg',
                                gradientColors: [
                                  Colors.purple,
                                  Colors.deepPurpleAccent
                                ],
                                onTap: () =>
                                    setState(() => selectedCategory = 'All'),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
            ),
            // Main content
            selectedCategory != "offers"
                ? SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Column(
                          children: [
                            Text(_title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            if (selectedCategory == "All" ||
                                selectedCategory == "food")
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: VegNonVegToggle(
                                  showVegOnly: showVegOnly,
                                  showNonVegOnly: showNonVegOnly,
                                  onToggle: (isVeg) {
                                    setState(() {
                                      if (isVeg == null) {
                                        showVegOnly = false;
                                        showNonVegOnly = false;
                                      } else if (isVeg) {
                                        showVegOnly = true;
                                        showNonVegOnly = false;
                                      } else {
                                        showNonVegOnly = true;
                                        showVegOnly = false;
                                      }
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      ...(selectedCategory == 'favourites' &&
                              filteredItems.isEmpty
                          ? [buildEmptyFavourites(selectedCategory, context)]
                          : filteredItems
                              .map((item) => buildFoodTile(context, item))
                              .toList()),
                      const SizedBox(height: 20),
                    ]),
                  )
                : const SliverToBoxAdapter(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Function(String) onCategorySelected;
  final TextEditingController controller;

  _StickyHeaderDelegate({
    required this.onCategorySelected,
    required this.controller,
  });

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
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
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
              children: [
                CategoryIcon(
                    icon: Icons.apps,
                    label: "All",
                    onTap: () => onCategorySelected("All")),
                CategoryIcon(
                    icon: Icons.fastfood,
                    label: "Food",
                    onTap: () => onCategorySelected("food")),
                CategoryIcon(
                    icon: Icons.local_drink,
                    label: "Juice",
                    onTap: () => onCategorySelected("beverages")),
                CategoryIcon(
                    icon: Icons.local_offer,
                    label: "Offers",
                    onTap: () => onCategorySelected("offers")),
                CategoryIcon(
                    icon: Icons.favorite,
                    label: "Favourites",
                    onTap: () => onCategorySelected("favourites")),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
