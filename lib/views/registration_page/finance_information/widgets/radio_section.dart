import 'package:flutter/material.dart';
import 'package:hotel_side/widgets/home_page_widgets/radio_button.dart';

class FinanceRadioSection extends StatelessWidget {
  final String title;
  final bool groupValue;
  final Function(bool?) onChanged;
  final String textYes;
  final String textNo;

  const FinanceRadioSection({
    super.key,
    required this.title,
    required this.groupValue,
    required this.onChanged,
    required this.textYes,
    required this.textNo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 16),
        CustomRadioButton(
          groupValue: groupValue,
          onChanged: onChanged,
          textYes: textYes,
          textNo: textNo,
        ),
      ],
    );
  }
}
