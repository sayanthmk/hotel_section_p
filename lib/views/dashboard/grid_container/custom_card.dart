import 'package:flutter/material.dart';

class EnhancedBookingCard extends StatelessWidget {
  final int count;
  final Widget percentageChangeWidget; // Change this to accept any widget
  final Gradient gradient; // Change this to accept only a gradient
  final String heading;
  final IconData icon; // Icon data for the icon
  final Color iconColor; // Color for the icon
  final Color iconBackgroundColor; // Background color for the icon

  const EnhancedBookingCard({
    super.key,
    required this.count,
    this.heading = '',
    this.percentageChangeWidget = const SizedBox(),
    this.gradient = const LinearGradient(
      // Provide a default gradient
      colors: [Colors.grey, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.icon = Icons.book, // Default icon
    this.iconColor = Colors.blue, // Default icon color
    this.iconBackgroundColor = Colors.blueAccent, // Default background color
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          iconBackgroundColor, // Use the passed background color here
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon, // Use the passed icon here
                      color: iconColor, // Use the passed icon color here
                      size: 24,
                    ),
                  ),
                  percentageChangeWidget, // Use the passed widget here
                ],
              ),
              const SizedBox(height: 10),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    heading,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


    // const SizedBox(width: 8),
                  // Container(
                  //   width: 6,
                  //   height: 6,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey[400],
                  //     shape: BoxShape.circle,
                  //   ),
                  // ),
                  // const SizedBox(width: 8),
                  // Text(
                  //   'This Month',
                  //   style: TextStyle(
                  //     color: Colors.grey[500],
                  //     fontSize: 14,
                  //   ),
                  // ),
                      // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 12,
                  //     vertical: 6,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: percentageChange >= 0
                  //         ? Colors.green[100]
                  //         : Colors.red[100],
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         percentageChange >= 0
                  //             ? Icons.arrow_upward
                  //             : Icons.arrow_downward,
                  //         color: percentageChange >= 0
                  //             ? Colors.green[700]
                  //             : Colors.red[700],
                  //         size: 16,
                  //       ),
                  //       const SizedBox(width: 4),
                  //       Text(
                  //         '${percentageChange.abs().toStringAsFixed(1)}%',
                  //         style: TextStyle(
                  //           color: percentageChange >= 0
                  //               ? Colors.green[700]
                  //               : Colors.red[700],
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                     // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Colors.blue[50]!,
          //     Colors.blue[100]!,
          //   ],
          // ),