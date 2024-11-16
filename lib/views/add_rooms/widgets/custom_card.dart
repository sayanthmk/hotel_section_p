import 'package:flutter/material.dart';

class CustomCardWithCheckbox extends StatelessWidget {
  final String title; // Card name
  final IconData icon; // Icon
  final bool value; // Checkbox value
  final ValueChanged<bool?>? onChanged; // Checkbox onChanged callback

  const CustomCardWithCheckbox({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
        // side: BorderSide(
        //   color: Colors.tealAccent.shade400, // Add a border color for emphasis
        //   width: 2.0,
        // ),
      ),
      color: const Color(0xff1E91B6), // Card background color
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Padding inside the card
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon, // Use the icon passed in the argument
                  color: Colors.white,
                ),
                const SizedBox(width: 10), // Space between icon and text
                Text(
                  title, // Use the title passed in the argument
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Bold text for emphasis
                    color: Colors.white, // White text for better contrast
                  ),
                ),
              ],
            ),
            Checkbox(
              value: value, // Bind to the passed value
              onChanged: onChanged, // Call the onChanged function
              activeColor: Colors.white, // White color for the active checkbox
              checkColor: const Color(0xff1E91B6), // Custom checkmark color
            ),
          ],
        ),
      ),
    );
  }
}
