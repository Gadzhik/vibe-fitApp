import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/nutrition_provider.dart';
import '../theme/cyber_theme.dart';
import '../widgets/grid_background.dart';
import '../widgets/neon_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/cyber_progress_bar.dart';
import 'add_entry_screen.dart';
import 'history_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NutritionProvider>(context);
    final todayStats = provider.todayStats;
    final now = DateTime.now();

    return Scaffold(
      body: GridBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                // Header Title
                const Center(
                  child: Text(
                    'КИБЕР ТРЕКЕР',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CyberTheme.cyan,
                      shadows: [Shadow(color: CyberTheme.cyan, blurRadius: 10)],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Date Card
                NeonCard(
                  neonColor: CyberTheme.primary,
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEEE', 'ru').format(now).toUpperCase(),
                            style: const TextStyle(
                              color: CyberTheme.cyan, // As per image text seems cyan/white
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('d MMMM yyyy', 'ru').format(now),
                            style: const TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CyberTheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: CyberTheme.primary),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${now.day}', 
                              style: const TextStyle(color: CyberTheme.primary, fontSize: 32, fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                const Text('СТАТИСТИКА ДНЯ', style: TextStyle(color: CyberTheme.cyan, fontSize: 16, shadows: [Shadow(color: CyberTheme.cyan, blurRadius: 5)])),
                const SizedBox(height: 12),
                
                // Stats Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    StatCard(
                      label: 'Калории',
                      value: '${todayStats['calories']}',
                      unit: 'ккал',
                      color: CyberTheme.primary,
                      icon: Icons.local_fire_department,
                    ),
                    StatCard(
                      label: 'Белки',
                      value: '${todayStats['protein']}',
                      unit: 'г',
                      color: CyberTheme.cyan,
                      icon: Icons.fitness_center,
                    ),
                    StatCard(
                      label: 'Жиры',
                      value: '${todayStats['fat']}',
                      unit: 'г',
                      color: CyberTheme.yellow,
                      icon: Icons.water_drop,
                    ),
                    StatCard(
                      label: 'Углеводы',
                      value: '${todayStats['carbs']}',
                      unit: 'г',
                      color: CyberTheme.green,
                      icon: Icons.grain,
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Goal Progress Section
                NeonCard(
                  neonColor: CyberTheme.cyan,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.bar_chart, color: CyberTheme.cyan),
                          SizedBox(width: 8),
                          Text('ПРОГРЕСС ЦЕЛЕЙ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CyberProgressBar(
                        label: 'Калории',
                        progress: provider.calorieProgress,
                        color: CyberTheme.primary,
                        height: 8,
                      ),
                      const SizedBox(height: 12),
                      CyberProgressBar(
                        label: 'Белки',
                        progress: provider.proteinProgress,
                        color: CyberTheme.cyan,
                        height: 8,
                      ),
                      const SizedBox(height: 12),
                      CyberProgressBar(
                        label: 'Жиры',
                        progress: provider.fatProgress,
                        color: CyberTheme.yellow,
                        height: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Space for FAB/BottomBar
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: CyberTheme.cyan,
        unselectedItemColor: Colors.white24,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 40), label: ''), // Center FAB placeholder
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
        ],
        onTap: (index) {
          if (index == 1) {
             Navigator.push(context, MaterialPageRoute(builder: (_) => const AddEntryScreen()));
          } else if (index == 2) {
             Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
          }
        },
      ),
    );
  }
}
