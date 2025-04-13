import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

Widget buildFoodTile(BuildContext context, FoodItem item) {
  final cartProvider = Provider.of<CartProvider>(context);
  final qty = cartProvider.getQuantity(item.id);

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 219, 208, 239),
          Color.fromARGB(255, 199, 176, 243)
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(
        color: const Color(0xFF4e29ac).withOpacity(0.3),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        item.isVeg ? Icons.circle : Icons.change_history,
                        size: 16,
                        color: item.isVeg ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          Provider.of<FavouritesProvider>(context)
                                  .isFavourite(item.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFF4e29ac),
                        ),
                        onPressed: () {
                          Provider.of<FavouritesProvider>(context,
                                  listen: false)
                              .toggleFavourite(item);
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${item.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4e29ac),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    item.image,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -2,
                  child: qty == 0
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4e29ac),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                cartProvider.addToCart(item);
                              },
                              child: const Text("ADD",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4e29ac),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
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
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  cartProvider.increaseQty(item.id);
                                },
                                iconSize: 18,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
