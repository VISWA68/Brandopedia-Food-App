import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const CartScreen(),
  ];

  DateTime? _lastBackPressed;

  Future<bool> _handleBackPress() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back button again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldExit = await _handleBackPress();
          if (shouldExit) {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          }
        }
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF4e29ac),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.account_circle_rounded), label: ''),
          ],
        ),
      ),
    );
  }
}
