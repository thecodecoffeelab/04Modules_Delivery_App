import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:farm_fresh_vendor/global/global.dart';
import 'package:farm_fresh_vendor/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Farm Fresh Alerts!',
            channelDescription: 'Delivery Alert!',
            defaultColor: Colors.white,
            playSound: true,
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
      title: 'Farm Fresh Vendors',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(),
    );
  }
}

