import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_user/assistantMethods/assistant_methods.dart';
import 'package:farm_fresh_user/models/menus.dart';
import 'package:farm_fresh_user/models/sellers.dart';
import 'package:farm_fresh_user/splashScreen/splash_screen.dart';
import 'package:farm_fresh_user/widgets/menus_design.dart';
import 'package:farm_fresh_user/widgets/progress_bar.dart';
import 'package:farm_fresh_user/widgets/text_widget_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';



class MenusScreen extends StatefulWidget
{
  final Sellers? model;
  MenusScreen({this.model});

  @override
  _MenusScreenState createState() => _MenusScreenState();
}



class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()
          {
            clearCartNow(context);

            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
            Fluttertoast.showToast(msg: "Cart cleared! Back to order delivery.");
          },
        ),
        title: const Text(
          "Farm Fresh | Fruits & Veggies",
          style: TextStyle(fontSize: 30, fontFamily: "Signatra", letterSpacing: 2),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
            SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString() + " Menus")),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection("menus")
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot)
              {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(child: circularProgress(),),
                )
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return MenusDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              },
            ),
        ],
      ),
    );
  }
}
