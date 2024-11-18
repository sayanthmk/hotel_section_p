import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final EdgeInsets padding;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final double borderRadius;

  const CustomSocialButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.size = 60,
    this.iconSize = 24,
    this.padding = const EdgeInsets.all(0),
    this.backgroundColor = Colors.white,
    this.boxShadow,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: size,
        height: size,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
        ),
        child: Icon(
          icon,
          color: color,
          size: iconSize,
        ),
      ),
    );
  }
}
