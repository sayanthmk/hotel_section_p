import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/auth_service/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EnhancedWelcomeCard extends StatelessWidget {
  final String userName;

  const EnhancedWelcomeCard({
    super.key,
    this.userName = 'Admin',
  });

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[600]!,
              Colors.blue[800]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Welcome Back,\n',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: authService.currentUser?.email
                                ?.split('@')[0]
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[800],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.bar_chart),
                    label: const Text(
                      'View Reports',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: Colors.white.withOpacity(0.8),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '5 New',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
