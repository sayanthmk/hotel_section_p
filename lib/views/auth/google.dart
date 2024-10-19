// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/auth_service/auth_service.dart';

// class GoogleSignInPage extends StatelessWidget {
//   const GoogleSignInPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Google Sign In')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Sign in with your Google account',
//               style: TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               child: const Text('Sign in with Google'),
//               onPressed: () async {
//                 try {
//                   await authService.signInWithGoogle();
//                   // ignore: use_build_context_synchronously
//                   Navigator.pop(context);

//                   // Navigator.of(context).push(MaterialPageRoute(
//                   //   builder: (context) => HomePage(),
//                   // ));
//                 } catch (e) {
//                   // ignore: use_build_context_synchronously
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('Failed to sign in with Google')),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
