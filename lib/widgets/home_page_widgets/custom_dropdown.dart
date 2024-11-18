import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? hintText;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hintText ?? 'Select an item'),
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          isExpanded: true,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            onChanged(newValue);
          },
        ),
      ),
    );
  }
}
