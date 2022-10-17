import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinemovieticket/admin/admin_home.dart';
import 'package:onlinemovieticket/admin/view_passed_out_show.dart';
import 'pages/splash_screen.dart';
import 'utils/mytheme.dart';

//Any Flutter Application Start it's Execution From Main Method In Flutter main.dart
// Contain Main Method So It Will Start Execution From Main.dart File

Future<void> main() async {
  //initialize app with Our Firebase database
  // using apikey,appid,messagingsenderid,projectid
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBZ96EWraVd5-BJwtYnb7yXp4LDXHbBXvg",
      appId: "1:771881495015:android:84e10a4f9eba57913db542",
      messagingSenderId: "771881495015",
      projectId: "movie-ticket-booking-app-f4e0b",
    ),
  );
//runapp method show's that from where it has to go next
  runApp(const MyApp());
}

//We create on statelesswidget MyApp And We write runApp(const MyApp()) so it will start from here.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Myapp Return SplashScreen So it Will Shows SplashScreen
    //Start Of The Application
    return GetMaterialApp(
      //this theme comes from utils mythemefile
      theme: MyTheme.myLightTheme,
      debugShowCheckedModeBanner: false,
      //As We Give home as SplashScreen It Will Redirect To SplashScreen.
      home: SplashScreen(),
    );
  }
}
