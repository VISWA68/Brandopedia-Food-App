import 'package:flutter/material.dart';

class VegNonVegToggle extends StatelessWidget {
  final bool showVegOnly;
  final bool showNonVegOnly;
  final Function(bool isVeg) onToggle;

  const VegNonVegToggle({
    super.key,
    required this.showVegOnly,
    required this.showNonVegOnly,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterChip(
          label: Row(
            children: [
              Image.asset('assets/images/broccoli.png', height: 18, width: 18),
              const SizedBox(width: 6),
              const Text("Veg"),
            ],
          ),
          selected: showVegOnly,
          onSelected: (val) => onToggle(true),
          selectedColor: Colors.green.withOpacity(0.2),
        ),
        const SizedBox(width: 6),
        FilterChip(
          label: Row(
            children: [
              Image.asset('assets/images/chicken-leg.png',
                  height: 20, width: 20),
              const SizedBox(width: 6),
              const Text("Non-Veg"),
            ],
          ),
          selected: showNonVegOnly,
          onSelected: (val) => onToggle(false),
          selectedColor: Colors.red.withOpacity(0.2),
        ),
      ],
    );
  }
}
