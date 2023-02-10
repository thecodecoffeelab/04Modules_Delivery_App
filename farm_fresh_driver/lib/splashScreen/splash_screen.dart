import 'dart:async';
import 'package:farm_fresh_driver/authentication/auth_screen.dart';
import 'package:farm_fresh_driver/global/global.dart';
import 'package:farm_fresh_driver/mainScreens/home_screen.dart';

import 'package:flutter/material.dart';





class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}


class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    Timer(const Duration(seconds: 3), () async
    {
      //if rider is loggedin already
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      //if rider is NOT loggedin already
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient:  LinearGradient(
            colors: [
              Colors.green,
              Colors.orange,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/fruit-vegetables-home-package-removebg-preview.png"),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "The Gambia's Largest Veggies & Fruits Delivery.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Signatra",
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}