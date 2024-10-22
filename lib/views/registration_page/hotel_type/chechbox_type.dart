import 'package:flutter/material.dart';
import 'package:hotel_side/widgets/home_page_widgets/custom_checkbox.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool?) onChanged;

  const CustomCheckboxTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCheckbox(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xff1E91B6),
          checkColor: Colors.white,
          size: 24.0,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
