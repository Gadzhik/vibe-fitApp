import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/nutrition_provider.dart';
import '../theme/cyber_theme.dart';
import '../widgets/cyber_container.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('СТАТИСТИКА')),
      body: Consumer<NutritionProvider>(
        builder: (context, provider, child) {
          final history = provider.dailyCaloriesHistory;
          final sortedDates = history.keys.toList()..sort();
          
          if (history.isEmpty) {
            return const Center(child: Text('НЕДОСТАТОЧНО ДАННЫХ', style: TextStyle(color: Colors.white54)));
          }

          // Calculate averages
          int totalCals = 0;
          for (var cals in history.values) {
            totalCals += cals;
          }
          final average = (totalCals / history.length).round();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CyberContainer(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text('СРЕДНЕЕ ПОТРЕБЛЕНИЕ', style: TextStyle(color: CyberTheme.cyan)),
                      const SizedBox(height: 10),
                      Text(
                        '$average',
                        style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const Text('ККАЛ / ДЕНЬ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Align(alignment: Alignment.centerLeft, child: Text('ПОСЛЕДНИЕ 7 ДНЕЙ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedDates.length > 7 ? 7 : sortedDates.length,
                    itemBuilder: (context, index) {
                      // Show last 7 days reversed
                      final date = sortedDates[sortedDates.length - 1 - index];
                      final cals = history[date]!;
                      final progress = (cals / NutritionProvider.calorieGoal).clamp(0.0, 1.0);
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                DateFormat('dd.MM', 'ru').format(date),
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: CyberTheme.surface,
                                  border: Border.all(color: Colors.white12),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.6 * progress,
                                    color: cals > NutritionProvider.calorieGoal ? CyberTheme.primary : CyberTheme.secondary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 50,
                              child: Text('$cals', style: const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
