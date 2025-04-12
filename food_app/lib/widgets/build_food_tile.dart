import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

Widget buildFoodTile(BuildContext context, FoodItem item) {
  final cartProvider = Provider.of<CartProvider>(context);
  final qty = cartProvider.getQuantity(item.id);

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(item.image,
                width: 90, height: 90, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(item.isVeg ? Icons.circle : Icons.change_history,
                        size: 16,
                        color: item.isVeg ? Colors.green : Colors.red),
                    GestureDetector(
                      onTap: () {
                        item.isFavourite = !item.isFavourite;
                        (context as Element).markNeedsBuild();
                      },
                      child: Icon(
                        item.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: item.isFavourite
                            ? const Color(0xFF4e29ac)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  "₹${item.price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Column(
            children: [
              const SizedBox(height: 16),
              qty == 0
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4e29ac),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () {
                        cartProvider.addToCart(item);
                      },
                      child: const Text("ADD",
                          style: TextStyle(color: Colors.white)),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF4e29ac),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              cartProvider.decreaseQty(item.id);
                            },
                            iconSize: 18,
                          ),
                          Text('$qty',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              cartProvider.increaseQty(item.id);
                            },
                            iconSize: 18,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}
