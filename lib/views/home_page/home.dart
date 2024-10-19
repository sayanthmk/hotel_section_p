import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authService.currentUser?.email ?? 'User'}!'),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
