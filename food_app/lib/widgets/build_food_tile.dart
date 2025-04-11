import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

Widget buildFoodTile(BuildContext context, FoodItem item) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: Hero(
        tag: 'food_${item.id}',
        child: Image.network(item.image, width: 60),
      ),
      title:
          Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('₹${item.price}'),
      trailing: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4e29ac)),
        onPressed: () =>
            Provider.of<CartProvider>(context, listen: false).addToCart(item),
        child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
