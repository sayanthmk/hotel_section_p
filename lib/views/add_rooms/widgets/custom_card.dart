import 'package:flutter/material.dart';

class CustomCardWithCheckbox extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool?>? onChanged;

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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xff1E91B6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: const Color(0xff1E91B6),
            ),
          ],
        ),
      ),
    );
  }
}
