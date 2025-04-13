import 'package:flutter/material.dart';

class CategoryIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryIcon({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CategoryIcon> createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.9);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: widget.onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          splashColor: Colors.deepPurple.withOpacity(0.2),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(widget.icon, size: 28, color: Colors.deepPurple),
              ),
              const SizedBox(height: 6),
              Text(widget.label,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
