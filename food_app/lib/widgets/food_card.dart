import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;
  const FoodCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(item.image, height: 100),
          Text(item.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('₹${item.price}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4e29ac)),
            onPressed: () {
              Provider.of<CartProvider>(context, listen: false).addToCart(item);
            },
            child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}