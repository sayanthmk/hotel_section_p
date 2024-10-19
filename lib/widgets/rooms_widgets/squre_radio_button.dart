import 'package:flutter/material.dart';

class RoomRadioButton extends StatelessWidget {
  final bool groupValue;
  final ValueChanged<bool?> onChanged;
  final String textYes;
  final String textNo;
  final String heading;

  const RoomRadioButton({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.textYes,
    required this.textNo,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Yes option with a decorative label
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor:
                        Colors.green, // Custom color for selected radio
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

              // No option with a decorative label
              Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    activeColor: Colors.red, // Custom color for selected radio
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
        ],
      ),
    );
  }
}
