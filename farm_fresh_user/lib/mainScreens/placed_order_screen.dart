import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_user/assistantMethods/assistant_methods.dart';
import 'package:farm_fresh_user/global/global.dart';
import 'package:farm_fresh_user/mainScreens/home_screen.dart';
import 'package:farm_fresh_user/mainScreens/my_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../notif_alerts/notify.dart';


class PlacedOrderScreen extends StatefulWidget
{
  String? addressID;
  double? totalAmount;
  String? sellerUID;

  PlacedOrderScreen({this.sellerUID, this.totalAmount, this.addressID});

  @override
  _PlacedOrderScreenState createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen>
{
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    addOrderDetails()
    {
      writeOrderDetailsForUser({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIDs": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Cash on Delivery",
        "orderTime": orderId,
        "isSuccess": true,
        "sellerUID": widget.sellerUID,
        "riderUID": "",
        "status": "normal",
        "orderId": orderId,
      });

      writeOrderDetailsForSeller({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIDs": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Cash on Delivery",
        "orderTime": orderId,
        "isSuccess": true,
        "sellerUID": widget.sellerUID,
        "riderUID": "",
        "status": "normal",
        "orderId": orderId,
      }).whenComplete((){
        clearCartNow(context);
        setState((){
          orderId="";
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
          Fluttertoast.showToast(msg: "Congratulations, your Farm Fresh order has been placed successfully.");
        });
      });
    }

    Future writeOrderDetailsForUser(Map<String, dynamic> data) async
    {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(sharedPreferences!.getString("uid"))
          .collection("orders")
          .doc(orderId)
          .set(data);
    }

    Future writeOrderDetailsForSeller(Map<String, dynamic> data) async
    {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .set(data);
    }


  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green,
                Colors.orange,
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

            Image.asset("images/farmdrive.jpg"),

            const SizedBox(height: 12,),

            ElevatedButton(
              child: const Text("Place the Order Now"),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

              ),
              onPressed: ()
              {
                  addOrderDetails();
                  NotifyAlert();
                    AwesomeNotifications().actionStream.listen((receivedNotification){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> MyOrdersScreen()),
                    );
                  });
              },
            ),

          ],
        ),
      ),
    );
  }
}
