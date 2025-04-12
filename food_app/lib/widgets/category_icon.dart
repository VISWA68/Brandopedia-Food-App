import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const CategoryIcon({super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF4e29ac),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}
