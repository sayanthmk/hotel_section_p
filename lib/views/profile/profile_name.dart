import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/auth_service/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 20),
      child: Column(
        children: [
          Text(
            // 'Denial Rozar',
            '${authService.currentUser?.email?.split('@')[0].toUpperCase()}',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            // 'denialrozar@gmail.com',
            authService.currentUser?.email ?? 'User',
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
