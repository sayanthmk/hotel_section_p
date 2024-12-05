import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/booking_provider/booking_provider.dart';
import 'package:hotel_side/controllers/hotel_provider/hotel_provider.dart';
import 'package:hotel_side/controllers/room_controller/roomprovider.dart';
import 'package:hotel_side/controllers/widgets_controller/widgets_controller.dart';
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
        ChangeNotifierProvider(create: (_) => WidgetsController()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth Demo',
        theme: ThemeData(
          // fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),

        // home: RoomsSubmissionPage(),
      ),
    );
  }
}
