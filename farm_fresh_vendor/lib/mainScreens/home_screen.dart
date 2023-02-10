import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_vendor/global/global.dart';
import 'package:farm_fresh_vendor/model/menus.dart';
import 'package:farm_fresh_vendor/splashScreen/splash_screen.dart';
import 'package:farm_fresh_vendor/uploadScreens/menus_upload_screen.dart';
import 'package:farm_fresh_vendor/widgets/info_design.dart';
import 'package:farm_fresh_vendor/widgets/my_drawer.dart';
import 'package:farm_fresh_vendor/widgets/progress_bar.dart';
import 'package:farm_fresh_vendor/widgets/text_widget_header.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  restrictBlockedSellersFromUsingApp() async
  {
    await FirebaseFirestore.instance.collection("sellers")
        .doc(firebaseAuth.currentUser!.uid)
        .get().then((snapshot)
    {
      if(snapshot.data()!["status"] != "approved")
      {
        Fluttertoast.showToast(msg: "The Farm Fresh Admin has blocked your Vendor account! \n\nPlease contact us for more details.");

        firebaseAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
      }
    });
  }

  @override
  void initState()
  {
    super.initState();
    
    restrictBlockedSellersFromUsingApp();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(fontSize: 35, fontFamily: "Signatra", letterSpacing: 2, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add, color: Colors.white,),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> const MenusUploadScreen()));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(
              title: "Farm Fresh Stock Products",)
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
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
                  return InfoDesignWidget(
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