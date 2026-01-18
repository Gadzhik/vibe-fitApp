import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';

class CyberContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CyberContainer({
    super.key, 
    required this.child, 
    this.width, 
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: CyberTheme.surface,
        border: Border.all(color: CyberTheme.secondary.withOpacity(0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: CyberTheme.secondary.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
