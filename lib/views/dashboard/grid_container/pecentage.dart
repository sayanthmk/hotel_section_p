import 'package:flutter/material.dart';

class PercentageChangeWidget extends StatelessWidget {
  final double percentageChange;

  const PercentageChangeWidget({
    super.key,
    required this.percentageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: percentageChange >= 0 ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            percentageChange >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
            color: percentageChange >= 0 ? Colors.green[700] : Colors.red[700],
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            '${percentageChange.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              color:
                  percentageChange >= 0 ? Colors.green[700] : Colors.red[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
