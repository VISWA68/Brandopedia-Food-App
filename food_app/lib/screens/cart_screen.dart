import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/screens/main_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    if (_showLoading) {
      return Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/cart.json',
            height: 500,
            width: 500,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/empty-cart.png', height: 300, width: 300),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Your cart is empty. Go ahead and add some delicious food!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 26),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
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
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(food.image,
                          width: 60, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text(
                      food.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                  Text(
                    'Total: ₹${cart.totalPrice}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4e29ac),
                    ),
                    onPressed: () {
                      // Add order logic here
                    },
                    child: const Text(
                      'Order Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
