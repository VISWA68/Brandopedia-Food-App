import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/widgets/food_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FoodItem> foodItems = [
      FoodItem(id: 1, name: 'Burger', price: 80, image: 'https://i.imgur.com/1N9nKvR.png'),
      FoodItem(id: 2, name: 'Pizza', price: 120, image: 'https://i.imgur.com/3jLPB46.png'),
      FoodItem(id: 3, name: 'Fries', price: 60, image: 'https://i.imgur.com/Z9qG1Da.png'),
      FoodItem(id: 4, name: 'Sandwich', price: 70, image: 'https://i.imgur.com/LrGp2Av.png'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF4e29ac),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4e29ac),
        title: const Text('Food Items', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          Hero(
            tag: 'cartHero',
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => const CartScreen(),
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: foodItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final item = foodItems[index];
            return FoodCard(item: item);
          },
        ),
      ),
    );
  }
}