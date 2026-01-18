import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import 'cyber_container.dart';

class StatsDisplay extends StatelessWidget {
  final String label;
  final int value;
  final String unit;
  final Color color;

  const StatsDisplay({
    super.key,
    required this.label,
    required this.value,
    this.unit = 'g',
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CyberContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '$value$unit',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
