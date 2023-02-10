import 'dart:async';

import 'package:farm_fresh_user/authentication/auth_screen.dart';
import 'package:farm_fresh_user/global/global.dart';
import 'package:farm_fresh_user/mainScreens/home_screen.dart';
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
    Timer(const Duration(seconds: 5), () async
    {
      //if user is loggedin already
      if(firebaseAuth.currentUser != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      //if user is NOT loggedin already
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
                child: Image.asset("images/dex_crop.jpg"),
              ),

              const SizedBox(height: 10,),

              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Farm Fresh Gambia!\n Online Fruits & Veggies Delivery!.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Bebas",
                    letterSpacing: 5,
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