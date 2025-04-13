import 'package:flutter/material.dart';
import 'package:food_app/screens/main_screen.dart';

Widget buildEmptyFavourites(String selectedCategory, BuildContext context) {
  if (selectedCategory != 'favourites') return SizedBox();

  return Center(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset(
                'assets/empty_favourites.png',
                height: 180,
              ),
              SizedBox(height: 24),
              Text(
                "No Favourites",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          'You can add an item to your favourites by clicking the ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    WidgetSpan(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite, color: Color(0xFF4e29ac)),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                    TextSpan(
                      text: ' icon.',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4e29ac),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Go Back",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
