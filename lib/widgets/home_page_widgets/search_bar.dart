import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final Color hintTextColor;
  final Color textColor;
  final Color backgroundColor;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.borderColor,
    required this.hintTextColor,
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 350,
      decoration: BoxDecoration(
        color: backgroundColor, // Background color of the search bar
        borderRadius: BorderRadius.circular(5), // Circular border
        border: Border.all(
          color: borderColor, // Border color passed as parameter
          width: 1, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,

              // Placeholder text
              hintStyle: TextStyle(
                color: hintTextColor, // Hint text color passed as parameter
              ),
              border: InputBorder.none, // Remove default border
              icon: Icon(
                Icons.search,
                color: hintTextColor, // Icon color is the same as hint text
              ),
            ),
            style: TextStyle(
              color: textColor, // Text color passed as parameter
            ),
          ),
        ),
      ),
    );
  }
}















// import 'package:flutter/material.dart';

// class CustomSearchBar extends StatelessWidget {
//   const CustomSearchBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(20.0),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8.0,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: const TextField(
//         decoration: InputDecoration(
//           hintText: 'Search hotel',
//           border: InputBorder.none,
//           icon: Icon(Icons.search, color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }
