import 'package:flutter/material.dart';
import '../models/food_entry.dart';
import '../services/storage_service.dart';

class NutritionProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<FoodEntry> _entries = [];

  List<FoodEntry> get entries => List.unmodifiable(_entries);

  // Daily goals (hardcoded for now, can be editable later)
  static const int calorieGoal = 2500;
  static const int proteinGoal = 150;
  static const int fatGoal = 80;
  static const int carbsGoal = 300;

  Future<void> init() async {
    await _storageService.init();
    _loadEntries();
  }

  void _loadEntries() {
    _entries = _storageService.getAllEntries();
    // Sort by date, newest first
    _entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    notifyListeners();
  }

  List<FoodEntry> getEntriesForDay(DateTime date) {
    return _entries.where((entry) {
      return entry.timestamp.year == date.year &&
             entry.timestamp.month == date.month &&
             entry.timestamp.day == date.day;
    }).toList();
  }

  // Get totals for today
  Map<String, int> get todayStats {
    final now = DateTime.now();
    final todayEntries = getEntriesForDay(now);
    
    return {
      'calories': todayEntries.fold(0, (sum, e) => sum + e.calories),
      'protein': todayEntries.fold(0, (sum, e) => sum + e.protein),
      'fat': todayEntries.fold(0, (sum, e) => sum + e.fat),
      'carbs': todayEntries.fold(0, (sum, e) => sum + e.carbs),
    };
  }

  // Calculate progress percentages (0.0 to 1.0)
  double get calorieProgress => (todayStats['calories']! / calorieGoal).clamp(0.0, 1.0);
  double get proteinProgress => (todayStats['protein']! / proteinGoal).clamp(0.0, 1.0);
  double get fatProgress => (todayStats['fat']! / fatGoal).clamp(0.0, 1.0);
  double get carbsProgress => (todayStats['carbs']! / carbsGoal).clamp(0.0, 1.0);

  Future<void> addEntry(String name, int calories, int protein, int fat, int carbs, [MealType mealType = MealType.breakfast]) async {
    final entry = FoodEntry(
      id: DateTime.now().toString(),
      name: name,
      calories: calories,
      protein: protein,
      fat: fat,
      carbs: carbs,
      timestamp: DateTime.now(),
      mealType: mealType,
    );
    
    await _storageService.addEntry(entry);
    _loadEntries(); // Reload to update UI
  }

  Map<DateTime, int> get dailyCaloriesHistory {
    final Map<DateTime, int> history = {};
    for (var entry in _entries) {
      final date = DateTime(entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);
      history[date] = (history[date] ?? 0) + entry.calories;
    }
    return history;
  }
}
