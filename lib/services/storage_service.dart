import 'package:hive_flutter/hive_flutter.dart';
import '../models/food_entry.dart';

class StorageService {
  static const String _boxName = 'food_entries';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MealTypeAdapter());
    Hive.registerAdapter(FoodEntryAdapter());
    await Hive.openBox<FoodEntry>(_boxName);
  }

  Box<FoodEntry> get _box => Hive.box<FoodEntry>(_boxName);

  List<FoodEntry> getAllEntries() {
    return _box.values.toList();
  }

  Future<void> addEntry(FoodEntry entry) async {
    await _box.put(entry.id, entry);
  }

  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
  }
}
