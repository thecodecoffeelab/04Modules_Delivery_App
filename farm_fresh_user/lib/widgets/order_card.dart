import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_user/mainScreens/order_details_screen.dart';
import 'package:farm_fresh_user/models/items.dart';
import 'package:flutter/material.dart';


class OrderCard extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDetailsScreen(orderID: orderID)));
      },
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black12,
                Colors.white54,
              ],
              begin:  FractionalOffset(0.0, 0.0),
              end:  FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: itemCount! * 125,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index)
          {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),
      ),
    );
  }
}


Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.grey[200],
    child: Row(
      children: [
        Image.network(model.thumbnailUrl!, width: 120,),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      model.title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Valera",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "GMD ",
                    style: TextStyle(fontSize: 16.0, color: Colors.pink, fontWeight: FontWeight.bold,),
                  ),
                  Text(
                    model.price.toString(),
                    style: const TextStyle(
                      color: Colors.pink,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  const Text(
                      "x ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                  ),
                  Expanded(
                    child: Text(
                      seperateQuantitiesList,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontFamily: "Valera",
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    ),
  );
}
