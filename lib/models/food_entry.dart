import 'package:hive/hive.dart';

part 'food_entry.g.dart';

@HiveType(typeId: 1)
enum MealType {
  @HiveField(0)
  breakfast,
  @HiveField(1)
  lunch,
  @HiveField(2)
  dinner,
  @HiveField(3)
  snack,
}

@HiveType(typeId: 0)
class FoodEntry {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final int calories;
  
  @HiveField(3)
  final int protein;
  
  @HiveField(4)
  final int fat;
  
  @HiveField(5)
  final int carbs;
  
  @HiveField(6)
  final DateTime timestamp;

  @HiveField(7)
  final MealType mealType;

  FoodEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.timestamp,
    this.mealType = MealType.breakfast, // Default for new entries (or migration if needed manually handled)
  });
}
