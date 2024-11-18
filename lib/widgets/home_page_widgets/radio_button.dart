import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool groupValue;
  final ValueChanged<bool?> onChanged;
  final String textYes;
  final String textNo;

  const CustomRadioButton({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.textYes,
    required this.textNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.green,
              ),
              const SizedBox(width: 5),
              Text(
                textYes,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: groupValue == true ? Colors.green : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio<bool>(
                value: false,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.red,
              ),
              const SizedBox(width: 5),
              Text(
                textNo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: groupValue == false ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
