import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_fresh_user/assistantMethods/assistant_methods.dart';
import 'package:farm_fresh_user/global/global.dart';
import 'package:farm_fresh_user/models/sellers.dart';
import 'package:farm_fresh_user/splashScreen/splash_screen.dart';
import 'package:farm_fresh_user/widgets/my_drawer.dart';
import 'package:farm_fresh_user/widgets/progress_bar.dart';
import 'package:farm_fresh_user/widgets/sellers_design.dart';
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
  final items = [
    "slider/1.jpg",
    "slider/2.png",
    "slider/3.png",
    "slider/4.jpg",
    "slider/5.png",
    "slider/6.png",
    "slider/7.png",
  ];

  restrictBlockedUsersFromUsingApp() async
  {
    await FirebaseFirestore.instance.collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get().then((snapshot)
      {
        if(snapshot.data()!["status"] != "approved")
        {
          Fluttertoast.showToast(msg: "The Farm Fresh Admin has blocked your User account! \n\nPlease contact us for more details.");

          firebaseAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
        }
        else
        {
          clearCartNow(context);
        }
      });
  }


  @override
  void initState() {
    super.initState();

    restrictBlockedUsersFromUsingApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.yellow,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          "Farm Fresh | Fruits & Veggies",
          style: TextStyle(fontSize: 32, fontFamily: "Signatra", color: Colors.deepOrange, letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .3,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: items.map((index) {
                    return Builder(builder: (BuildContext context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            index,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index)
                {
                  Sellers sModel = Sellers.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>
                  );
                  //design for display sellers-cafes-restuarents
                  return SellersDesignWidget(
                    model: sModel,
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