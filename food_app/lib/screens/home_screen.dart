import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/widgets/build_food_tile.dart';
import 'package:food_app/widgets/food_card.dart';
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
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Chennai',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
                backgroundColor: Color(0xFF4e29ac),
                child: Icon(Icons.person, color: Colors.white)),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search for restaurants or dishes',
              filled: true,
              fillColor: Color(0xFFF2F2F2),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Column(
                children: [
                  Icon(Icons.fastfood, color: Color(0xFF4e29ac)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Food",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.local_drink, color: Color(0xFF4e29ac)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Beverages",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.local_offer, color: Color(0xFF4e29ac)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Offers",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite, color: Color(0xFF4e29ac)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Favourites",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildBanner('30% OFF\nUP TO 10.175', Colors.orange),
                buildBanner('30% OFF\nTRY IT NOW', Colors.blue),
                buildBanner('50% OFF\nUSE 302406', Colors.deepPurple),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('Explore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...foodItems.map((item) => buildFoodTile(context, item)).toList(),
        ],
      ),
    );
  }
}
