import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:farm_fresh_user/assistantMethods/address_changer.dart';
import 'package:farm_fresh_user/assistantMethods/cart_Item_counter.dart';
import 'package:farm_fresh_user/assistantMethods/total_amount.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c)=> CartItemCounter()),
        ChangeNotifierProvider(create: (c)=> TotalAmount()),
        ChangeNotifierProvider(create: (c)=> AddressChanger()),
      ],
      child: MaterialApp(
        title: 'Users App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}

