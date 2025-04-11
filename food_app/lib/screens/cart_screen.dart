import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4e29ac),
        leading: Hero(
          tag: 'cartHero',
          child: IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
      ),
      body: items.isEmpty
          ? const Center(child: Text('Cart is Empty'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final food = items[index]['item'] as FoodItem;
                final qty = items[index]['qty'] as int;
                return ListTile(
                  leading: Image.network(food.image, width: 50),
                  title: Text(food.name),
                  subtitle: Text('₹${food.price} x $qty = ₹${food.price * qty}'),
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
                );
              },
            ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: ₹${cart.totalPrice}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4e29ac)),
              onPressed: () {},
              child: const Text('Order Now', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}