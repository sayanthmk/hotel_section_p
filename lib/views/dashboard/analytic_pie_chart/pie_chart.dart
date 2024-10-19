import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnalyticChart extends StatelessWidget {
  const AnalyticChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Analytics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text('Live'),
                  backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: 0.78,
                  center: const Text('78%'),
                  progressColor: Colors.blue,
                  header: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Occupancy'),
                  ),
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: 0.92,
                  center: const Text('92%'),
                  progressColor: Colors.green,
                  header: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Revenue'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
