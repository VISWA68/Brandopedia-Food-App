import 'package:flutter/material.dart';

Widget buildBanner(String text, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 12),
    width: 160,
    padding: const EdgeInsets.all(16),
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, padding: EdgeInsets.zero),
          child: Text('Order Now',
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
