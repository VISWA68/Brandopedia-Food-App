class FoodItem {
  final int id;
  final String name;
  final int price;
  final String image;
  final String foodType;
  final bool isVeg; 
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
