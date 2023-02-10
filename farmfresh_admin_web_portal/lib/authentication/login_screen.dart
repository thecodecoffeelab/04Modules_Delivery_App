import 'package:farmfresh_admin_web_portal/main_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
   _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  String adminEmail = "";
  String adminPassword = "";

    //function to allow the admin to Login
  allowAdminToLogin() async
  {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Farm Fresh Administration is checking your credentials, Please wait...",
        style: TextStyle(
          fontSize: 36,
          color: Colors.green,
        ),
      ),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: adminEmail,
        password:adminPassword,
    ).then((fAuth)
    {
      currentAdmin = fAuth.user;
    }).catchError((onError)
    {
        //display error login message
      final snackBar = SnackBar(
        content: Text(
            "Error Login: " + onError.toString(),
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 6),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if (currentAdmin != null)
    {
      //checking if that admin record exists in the admins collection in the firestore database
      await FirebaseFirestore
          .instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get().then((snap)
      {
            if(snap.exists)
            {

              Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));

              SnackBar snackBar = const SnackBar(
                content: Text(
                  "Welcome! Farm Fresh Online Fruits & Veggies Delivery.",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.orange,
                  ),
                ),
                backgroundColor: Colors.black,
                duration: Duration(seconds: 7),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            else
            {
              SnackBar snackBar = const SnackBar(
                content: Text(
                  "No record found, your are not a Farm Fresh Admin! Please, if your not authorized, stop trying or your IP address & location will be reported.",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.green,
                  ),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 6),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

            }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //image admin
                  Image.asset(
                      "images/gen.png"
                  ),

                  //email Textfield
                  TextField(
                    onChanged: (value)
                    {
                      adminEmail = value;
                    },
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                        ),
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2
                        ),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
                  //password Textfield
                  TextField(
                    onChanged: (value)
                    {
                      adminPassword = value;
                    },
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      icon: Icon(
                        Icons.admin_panel_settings,
                        color: Colors.green,
                      ),
                    ),
                  ),

                       SizedBox(height: 30,),
                       //Login button
                          ElevatedButton(
                            onPressed: ()
                            {
                                allowAdminToLogin();
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 99, vertical: 20)),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                            ),
                            child: const Text(
                              "Login To Panel",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
