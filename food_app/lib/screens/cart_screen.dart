import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/main_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      backgroundColor: items.isEmpty ? Color(0xFFE8D3E8) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cart',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cart is Empty :(',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Lottie.asset('assets/lottie.json', height: 250, width: 250),
                  const SizedBox(height: 16),
                  const Text(
                    'Hungry? Add some delicious food!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4e29ac),
                      minimumSize: const Size(200, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Browse Menu',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final food = items[index]['item'] as FoodItem;
                final qty = items[index]['qty'] as int;
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: Hero(
                      tag: 'food_${food.id}',
                      child: Image.network(food.image, width: 60),
                    ),
                    title: Text(food.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle:
                        Text('₹${food.price} x $qty = ₹${food.price * qty}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cart.decreaseQty(food.id),
                        ),
                        Text('$qty'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cart.increaseQty(food.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: ₹${cart.totalPrice}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4e29ac)),
                    onPressed: () {},
                    child: const Text('Order Now',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
