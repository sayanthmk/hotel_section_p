import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color textColor;

  const CustomSection({
    super.key,
    required this.title,
    required this.children,
    this.textColor = const Color(0xFF2D3142),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}



class CustomContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color primaryColor;

  const CustomContinueButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.primaryColor = const Color(0xff1E91B6),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
