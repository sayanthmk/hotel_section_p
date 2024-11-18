// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class RevenueGraph extends StatelessWidget {
//   const RevenueGraph({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Revenue Overview',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               height: 200,
//               child: LineChart(
//                 LineChartData(
//                   gridData: const FlGridData(show: false),
//                   titlesData: const FlTitlesData(
//                     show: true,
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: const [
//                         FlSpot(0, 3),
//                         FlSpot(2, 2),
//                         FlSpot(4, 5),
//                         FlSpot(6, 3.1),
//                         FlSpot(8, 4),
//                         FlSpot(10, 3),
//                       ],
//                       isCurved: true,
//                       color: Colors.blue,
//                       barWidth: 3,
//                       isStrokeCapRound: true,
//                       dotData: const FlDotData(show: false),
//                       belowBarData: BarAreaData(
//                         show: true,
//                         color: Colors.blue.withOpacity(0.1),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
