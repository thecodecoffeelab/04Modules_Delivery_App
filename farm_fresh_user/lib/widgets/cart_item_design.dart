
import 'package:farm_fresh_user/models/items.dart';
import 'package:flutter/material.dart';


class CartItemDesign extends StatefulWidget
{
 final Items? model;
 BuildContext? context;
 final int? quanNumber;

 CartItemDesign({
   this.model,
   this.context,
   this.quanNumber,
});

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: 97,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [

              Image.network(widget.model!.thumbnailUrl!, width: 140, height: 120,),

              const SizedBox(width: 6,),

              //title
              //quantity number
              //price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Valera",
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),

                  //quantity number
                  Row(
                    children: [
                     const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Valera",
                        ),
                      ),
                      Text(
                        widget.quanNumber.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Valera",
                        ),
                      ),
                    ],
                  ),

                  //price
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "GMD ",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.model!.price.toString(),
                        style: const TextStyle(
                          color: Colors.pink,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
