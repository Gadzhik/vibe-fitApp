import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';

class CyberProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final Color color;
  final String label;

  const CyberProgressBar({
    super.key,
    required this.progress,
    this.height = 10,
    required this.color,
    this.label = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                Text('${(progress * 100).toInt()}%', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: CyberTheme.surface.withOpacity(0.5),
            border: Border.all(color: Colors.white12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: height,
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    color: color,
                    boxShadow: [
                      BoxShadow(color: color.withOpacity(0.6), blurRadius: 8, spreadRadius: 0),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
