class FoodItem {
  final int id;
  final String name;
  final int price;
  final String image;
  final String foodType; // 'snacks', 'beverages', 'food'
  final bool isVeg; // true for veg, false for non-veg
  bool isFavourite;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.foodType,
    required this.isVeg,
    this.isFavourite = false,
  });
}
