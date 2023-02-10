import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_user/global/global.dart';
import 'package:farm_fresh_user/mainScreens/home_screen.dart';
import 'package:farm_fresh_user/notif_alerts/welcome_alert.dart';
import 'package:farm_fresh_user/widgets/custom_text_field.dart';
import 'package:farm_fresh_user/widgets/error_dialog.dart';
import 'package:farm_fresh_user/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'auth_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen>
{

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            message: "Please write your email and password.",
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
      await FirebaseFirestore.instance.collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
          if(snapshot.exists)
          {
            if(currentUser.emailVerified && snapshot.data()!["status"] == "approved")
            {
              await sharedPreferences!.setString("uid", currentUser.uid);
              await sharedPreferences!.setString("email", snapshot.data()!["email"]);
              await sharedPreferences!.setString("name", snapshot.data()!["name"]);
              await sharedPreferences!.setString("photoUrl", snapshot.data()!["photoUrl"]);

              List<String> userCartList = snapshot.data()!["userCart"].cast<String>();
              await sharedPreferences!.setStringList("userCart", userCartList);

              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
              WelcomeAlert();
            }
            else
            {
              firebaseAuth.signOut();
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "The FattFatt administration has blocked your user account or your email is not verified yet. \n\nPlease call us at: +220 269-3333 or +220 317-7759 for more details to activate it back, \n\nThank you!");
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
                    message: "No record is found in FattFatt database.",
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
                  "images/freshy-removebg-preview.png",
                  height: 270,
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
              "Login In",
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
