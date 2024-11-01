import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/field_information/hotel_provider.dart';
import 'package:hotel_side/controllers/field_information/roomprovider.dart';
import 'package:hotel_side/controllers/widgets_controller/widgets_controlle.dart';
import 'package:hotel_side/views/add_rooms/images_upload.dart';
import 'package:hotel_side/views/add_rooms/room_amentites/room_amentities.dart';
import 'package:hotel_side/views/add_rooms/room_facilities.dart';
import 'package:hotel_side/views/add_rooms/room_final_review.dart';
import 'package:hotel_side/views/add_rooms/room_type.dart';
import 'package:hotel_side/views/bottom_nav/bottom_nav.dart';
import 'package:hotel_side/views/dashboard/hotel_dash.dart';
import 'package:hotel_side/views/registration_page/basic_info/basic_information.dart';
import 'package:hotel_side/views/registration_page/final_review_page/final_review.dart';
import 'package:hotel_side/views/registration_page/finance_information/finance_information.dart';
import 'package:hotel_side/views/registration_page/hotel_type/hotel_type_select.dart';
import 'package:hotel_side/views/registration_page/images_page/images.dart';
import 'package:hotel_side/views/registration_page/location/manual_location.dart';
import 'package:hotel_side/views/registration_page/poilcy_page/policies.dart';
import 'package:hotel_side/views/rooms_list/rooms_list.dart';
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth Demo',
        theme: ThemeData(
          // fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        // home: AuthWrapper(),

        home: RoomsSubmissionPage(),
      ),
    );
  }
}
