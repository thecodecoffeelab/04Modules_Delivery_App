import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_driver/alerts/check_orders.dart';
import 'package:farm_fresh_driver/authentication/auth_screen.dart';
import 'package:farm_fresh_driver/global/global.dart';
import 'package:farm_fresh_driver/mainScreens/home_screen.dart';
import 'package:farm_fresh_driver/widgets/custom_text_field.dart';
import 'package:farm_fresh_driver/widgets/error_dialog.dart';
import 'package:farm_fresh_driver/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  formValidation()
  {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
    {
      //login
      loginNow();
    }
    else
    {
      showDialog(
        context: context,
        builder: (c)
        {
          return ErrorDialog(
            message: "Please write your email & password.",
          );
        }
      );
    }
  }


  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return LoadingDialog(
            message: "Farm Fresh is checking your credentials",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth){
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );
    });
    if(currentUser != null && currentUser!.emailVerified)
    {
      readDataAndSetDataLocally(currentUser!);
    }
  }


  Future readDataAndSetDataLocally(User currentUser) async
  {
    await FirebaseFirestore.instance.collection("riders")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
          if(snapshot.exists)
          {
            if(snapshot.data()!["status"] == "approved")
            {
              await sharedPreferences!.setString("uid", currentUser.uid);
              await sharedPreferences!.setString("email", snapshot.data()!["riderEmail"]);
              await sharedPreferences!.setString("name", snapshot.data()!["riderName"]);
              await sharedPreferences!.setString("photoUrl", snapshot.data()!["riderAvatarUrl"]);

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
              CheckOrders();

            }
            else
              {
                firebaseAuth.signOut();
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "The Farm Fresh administration has blocked your driver account or your email is not confirmed yet.\n\nThank you!");

              }

          }
          else
          {
            firebaseAuth.signOut();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));

            showDialog(
                context: context,
                builder: (c)
                {
                  return ErrorDialog(
                    message: "no record exists in Farm Fresh databases.",
                  );
                }
            );
          }

        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                  "images/fruit-and-vegetable-business-management-app.png",
                  height: 200,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextField(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: ()
            {
              formValidation();
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}

