import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String buttonText1;
  final String buttonText2;
  final VoidCallback onPressButton1;
  final VoidCallback onPressButton2;

  const CustomAlertDialog({
    super.key,
    required this.titleText,
    required this.contentText,
    required this.buttonText1,
    required this.buttonText2,
    required this.onPressButton1,
    required this.onPressButton2,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      backgroundColor: Colors.white,
      elevation: 10, // Add shadow for depth
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title section
            Row(
              children: [
                Icon(Icons.info_outline,
                    size: 28, color: Colors.blueAccent), // Add an icon
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16), // Add space between title and content

            // Content section
            Text(
              contentText,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center, // Center align the content text
            ),
            const SizedBox(height: 24), // Space between content and buttons

            // Buttons section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onPressButton1,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Custom button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded button
                    ),
                  ),
                  child: Text(
                    buttonText1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onPressButton2,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red), // Border color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded button
                    ),
                  ),
                  child: Text(
                    buttonText2,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
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
