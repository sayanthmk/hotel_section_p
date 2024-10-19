import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 20),
      child: Column(
        children: [
          Text(
            'Denial Rozar',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'denialrozar@gmail.com',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          // const SizedBox(height: 20),
        ],
      ),
    );
  }
}
