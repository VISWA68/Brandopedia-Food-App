import 'package:flutter/material.dart';

Widget buildBanner(String text, Color color, String imageUrl) {
  return Container(
    margin: const EdgeInsets.only(right: 12),
    width: 200,
    height: 120,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: 6,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: color,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Order Now"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
