import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/auth_service/auth_service.dart';

class CodeVerificationPage extends StatelessWidget {
  final String verificationId;

  CodeVerificationPage({super.key, required this.verificationId});

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Verify Code')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _codeController,
                decoration:
                    const InputDecoration(labelText: 'Verification code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Verify Code'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: _codeController.text,
                      );
                      await authService.signInWithPhoneCredential(credential);
                      Navigator.of(context).popUntil((route) => route
                          .isFirst); // Return to the first page after successful sign-in
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Failed to verify code: ${e.toString()}')),
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
