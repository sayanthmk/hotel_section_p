import 'package:flutter/material.dart';
import 'package:hotel_side/views/auth/phone_verification.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../controllers/auth_service/auth_service.dart';

class PhoneInputPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';

  PhoneInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Phone Sign In')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'US', // Set initial country code here
                onChanged: (phone) {
                  _phoneNumber = phone.completeNumber;
                },
                validator: (phone) {
                  if (phone == null || phone.number.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Send Verification Code'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await authService.signInWithPhone(
                        _phoneNumber,
                        (phoneAuthCredential) async {
                          // Auto-retrieval of the code on some devices
                          await authService
                              .signInWithPhoneCredential(phoneAuthCredential);
                          Navigator.of(context)
                              .pop(); // Return to previous page after successful sign-in
                        },
                        (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${error.message}')),
                          );
                        },
                        (verificationId, resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CodeVerificationPage(
                                  verificationId: verificationId),
                            ),
                          );
                        },
                        (verificationId) {
                          print('Auto-retrieval timeout');
                        },
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Failed to send code: ${e.toString()}')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
