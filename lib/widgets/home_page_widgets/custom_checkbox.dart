import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final double size;

  const CustomCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.size = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: value
              ? (activeColor ?? Theme.of(context).primaryColor)
              : Colors.transparent,
          border: Border.all(
            color: value
                ? (activeColor ?? Theme.of(context).primaryColor)
                : Colors.grey,
            width: 2.0,
          ),
        ),
        width: size,
        height: size,
        child: value
            ? Icon(
                Icons.check,
                size: size * 0.7,
                color: checkColor ?? Colors.white,
              )
            : null,
      ),
    );
  }
}
