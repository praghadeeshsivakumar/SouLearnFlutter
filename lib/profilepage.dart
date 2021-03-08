import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'userdetails.dart';
import 'dart:async';

class ProfileUI2 extends StatefulWidget {
  UserDetails userDetails;
  ProfileUI2({@required this.userDetails});

  @override
  _ProfileUI2State createState() => _ProfileUI2State();
}

class _ProfileUI2State extends State<ProfileUI2> {
  CollectionReference userColRef = Firestore.instance.collection("Users");
  bool loadingState = true;
  dynamic currentDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        loadingState = false;
      });
    });
    readFromFirestore();
  }

  readFromFirestore() async {
    await userColRef
        .document(widget.userDetails.userUID)
        .get()
        .then((DocumentSnapshot ds) {
      currentDate = ds['joinDate'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SafeArea(
          child: loadingState
              ? shimmerPlaceHolder()
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.pinimg.com/originals/9b/a5/a2/9ba5a220b73eb7cf1eabcbedf3101fe9.jpg'),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.userDetails.photoUrl),
                            radius: 60.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      widget.userDetails.userName,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.userDetails.userEmail,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "SouLearn's member for",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 100,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            (DateTime.now().difference(
                                                    DateTime.parse(
                                                        currentDate)))
                                                .inHours
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 50.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text("hours")
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
        ));
  }

  Widget shimmerPlaceHolder() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ProfilePageShimmer(),
          VideoShimmer(),
          ListTileShimmer(),
          ListTileShimmer(),
          ListTileShimmer()
        ],
      ),
    );
  }
}
