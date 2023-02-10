import 'dart:async';
import 'package:farm_fresh_vendor/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen>
{
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;

  @override
  void initState()
  {
    user = auth.currentUser!;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose()
  {
    timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.blue,
              ],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset("images/email.png"),

            const SizedBox(height: 12,),

            ElevatedButton(
              child: Text(
                  "Email sent to:\n ${user!.email}, \n\nConfirm the mail & access your account!",
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              ),
              onPressed: ()
              {
                Fluttertoast.showToast(msg: "Confirm your the mail now & access your account!");
              },
            ),

          ],
        ),
      ),
    );
  }

  Future <void> checkEmailVerified() async
    {
       user = auth.currentUser!;
       await user!.reload();
       if(user!.emailVerified)
       {
         timer!.cancel();
         Navigator.of(context)
             .pushReplacement(MaterialPageRoute(builder: (context)=> const MySplashScreen()));
       }
    }
}
