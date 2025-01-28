import 'package:flutter/material.dart';

class HotelSideCustomAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String heading;
  final List<Widget>? appbaractions;
  const HotelSideCustomAppbar({
    required this.heading,
    this.appbaractions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        heading,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue[300],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      actions: appbaractions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


// class HotelSideCustomAppbar extends StatelessWidget {
//   const HotelSideCustomAppbar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text(
//         'My Bookings',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       centerTitle: true,
//       backgroundColor: Colors.blue[300],
//       elevation: 0,
//       iconTheme: const IconThemeData(color: Colors.white),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           bottom: Radius.circular(20),
//         ),
//       ),
//     );
//   }
// }