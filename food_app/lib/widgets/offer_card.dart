import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final List<Color> gradientColors;
  final VoidCallback? onTap;

  const OfferCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.gradientColors,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 6),
                  Text(subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(imagePath, fit: BoxFit.cover, height: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
