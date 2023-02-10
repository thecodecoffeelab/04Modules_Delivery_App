import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global/global.dart';
import 'splashScreen/splash_screen.dart';



Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Farm Fresh Alert!',
            channelDescription: 'Farm Fresh Delivery Alert!',
            defaultColor: Colors.white,
            playSound: false,
            enableLights: true,
            enableVibration: true
        )
      ]
  );
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Fresh Drivers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MySplashScreen(),
    );
  }
}
