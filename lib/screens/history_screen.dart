import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/nutrition_provider.dart';
import '../models/food_entry.dart';
import '../theme/cyber_theme.dart';
import '../widgets/cyber_container.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ИСТОРИЯ')),
      body: Consumer<NutritionProvider>(
        builder: (context, provider, child) {
          final entries = provider.entries;
          // Group entries by day
          final Map<String, List<dynamic>> groupedEntries = {};
          
          for (var entry in entries) {
            final dateKey = DateFormat('yyyy-MM-dd').format(entry.timestamp);
            if (!groupedEntries.containsKey(dateKey)) {
              groupedEntries[dateKey] = [];
            }
            groupedEntries[dateKey]!.add(entry);
          }
          
          final mealNames = {
            MealType.breakfast: 'Завтрак',
            MealType.lunch: 'Обед',
            MealType.dinner: 'Ужин',
            MealType.snack: 'Перекус',
          };
          
          final sortedKeys = groupedEntries.keys.toList()..sort((a, b) => b.compareTo(a));

          if (entries.isEmpty) {
            return const Center(child: Text('НЕТ ДАННЫХ', style: TextStyle(color: Colors.white54)));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedKeys.length,
            itemBuilder: (context, index) {
              final dateKey = sortedKeys[index];
              final dateEntries = groupedEntries[dateKey]!;
              final displayDate = DateFormat('d MMMM yyyy', 'ru').format(DateTime.parse(dateKey));
              
              final totalCals = dateEntries.fold<int>(0, (sum, e) => sum + (e.calories as int));

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CyberContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(displayDate, style: const TextStyle(color: CyberTheme.cyan, fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('$totalCals ккал', style: const TextStyle(color: CyberTheme.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(color: Colors.white24),
                      ...dateEntries.map((entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.name, style: const TextStyle(color: Colors.white70)),
                                Text(mealNames[entry.mealType] ?? '', style: TextStyle(color: CyberTheme.cyan.withOpacity(0.7), fontSize: 10)),
                              ],
                            ),
                            Text('${entry.calories} ккал', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
