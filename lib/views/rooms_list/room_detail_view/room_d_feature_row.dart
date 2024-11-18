import 'package:flutter/material.dart';

class FeatureRow extends StatelessWidget {
  final String feature;
  final bool isAvailable;
  final IconData? customIcon;
  final Color? activeColor;
  final Color? inactiveColor;

  const FeatureRow({
    super.key,
    required this.feature,
    required this.isAvailable,
    this.customIcon,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isAvailable
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isAvailable
              ? (activeColor ?? Colors.green).withOpacity(0.3)
              : (inactiveColor ?? Colors.red).withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isAvailable
                  ? (activeColor ?? Colors.green).withOpacity(0.1)
                  : (inactiveColor ?? Colors.red).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              customIcon ?? (isAvailable ? Icons.check_circle : Icons.cancel),
              color: isAvailable
                  ? (activeColor ?? Colors.green)
                  : (inactiveColor ?? Colors.red),
              size: 24,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isAvailable ? Colors.black87 : Colors.black54,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: isAvailable
                  ? (activeColor ?? Colors.green).withOpacity(0.1)
                  : (inactiveColor ?? Colors.red).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              isAvailable ? 'Available' : 'Not Available',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isAvailable
                    ? (activeColor ?? Colors.green)
                    : (inactiveColor ?? Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
