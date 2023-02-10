import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';



class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}


class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.greenAccent,
                  Colors.orange,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
              "Farm Fresh | Fruits & Veggies",
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontFamily: "Signatra",
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.green,size: 28,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.green,size: 28,),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.lightGreen,
                Colors.orange,
              ],
            )
          ),
          child: const TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
