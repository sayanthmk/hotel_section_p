import 'package:flutter/material.dart';

class EnhancedBookingCard extends StatelessWidget {
  final int count;
  final Widget percentageChangeWidget; 
  final Gradient gradient; 
  final String heading;
  final IconData icon; 
  final Color iconColor; 
  final Color iconBackgroundColor; 

  const EnhancedBookingCard({
    super.key,
    required this.count,
    this.heading = '',
    this.percentageChangeWidget = const SizedBox(),
    this.gradient = const LinearGradient(
     
      colors: [Colors.grey, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.icon = Icons.book, 
    this.iconColor = Colors.blue,
    this.iconBackgroundColor = Colors.blueAccent, 
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
                          iconBackgroundColor, 
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon, 
                      color: iconColor, 
                      size: 24,
                    ),
                  ),
                  percentageChangeWidget, 
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

