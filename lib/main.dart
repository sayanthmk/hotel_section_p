import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/views/dashboard/hotel_dash.dart';
import 'package:hotel_side/views/registration_page/final_review_page/final_review.dart';
import 'package:hotel_side/views/registration_page/finance_information.dart';
import 'package:hotel_side/views/registration_page/hotel_type_select.dart';
import 'package:hotel_side/views/splash_screen/splash.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => HotelProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth Demo',
        theme: ThemeData(
          // fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        // home: const AuthWrapper(),

        home: FinanceInformation(),
      ),
    );
  }
}
