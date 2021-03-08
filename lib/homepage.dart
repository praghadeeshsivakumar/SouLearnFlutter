import 'package:flutter/material.dart';
import 'package:learnable/profilepage.dart';
import 'package:learnable/userdetails.dart';
import 'package:learnable/videolistpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:learnable/volunteerpage.dart';
import 'package:learnable/welcomepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final UserDetails userDetails;
  HomePage({@required this.userDetails});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loadingState = true;
  String theQuoteToBeDisplayed = 'May the force be with you';
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'praghadeeshtks@zohomail.in',
      queryParameters: {'subject': "I found a bug in the app 🧐"});

  //GoogleSignInObject
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //Firebase Object
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        loadingState = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.black,
              ),
              onPressed: () => Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (builder) =>
                          ProfileUI2(userDetails: widget.userDetails))),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/images/learnable.png",
            scale: 7,
          ),
        ),
        drawer: new Drawer(child: drawerContent()),
        body: loadingState ? shimmerPlaceHolder() : bodyContent());
  }

  Widget bodyContent() {
    return SafeArea(
        child: Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              sourashtraCard(),

              containerCard("Electronics",
                  "https://1.bp.blogspot.com/-4wrxnWI4HT0/XWJIILswIAI/AAAAAAAALuY/qaOpQzaw_IA7dt-C4d2yApIYvIrT7uqJQCLcBGAs/w914-h514-p-k-no-nu/circuit-digital-art-uhdpaper.com-4K-4.308-wp.thumbnail.jpg",
                  () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (builder) => new VideoListPage(
                              domain: "electronics",
                            )));
              }),
              containerCard("Programming",
                  "https://image.freepik.com/free-vector/programmer-coding-young-man-freelancer-working-program-code-with-laptop-geek-coding-software-vector-concept_53562-9214.jpg",
                  () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (builder) => new VideoListPage(
                              domain: "programming",
                            )));
              }),
              containerCard("Finance",
                  "https://i.ytimg.com/vi/GVGVFmluXTg/maxresdefault.jpg", () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (builder) => new VideoListPage(
                              domain: "finance",
                            )));
              }),
              //materialCard(),
              skillCard(),
              motherCard()
            ],
          ),
        ),
      ),
    ));
  }

  Widget drawerContent() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Center(
              child: Image.asset(
                "assets/images/learnable.png",
                scale: 7,
              ),
            ),
            handleDrawerButton(() {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (builder) =>
                          new ProfileUI2(userDetails: widget.userDetails)));
            }, "Profile"),
            handleDrawerButton(() {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (builder) => VolunteerPage()));
            }, "Volunteer"),
            handleDrawerButton(() async {
              await launch(_emailLaunchUri.toString());
            }, "Report a Bug"),
            handleDrawerButton(() {
              launchPrivacyPoilcy();
            }, "Privacy Policy"),
            handleDrawerButton(() {
              handleSignOut();
            }, "Logout and Exit"),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text(
                  "ꢱꣃꢬꢵꢰ꣄ꢜ꣄ꢬ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                SpinKitPumpingHeart(
                  color: Colors.blue,
                  size: 28.0,
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text("© 2021 SouLearn"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget handleDrawerButton(onTap, String data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 6.0, 5.0, 6.0),
      child: InkWell(
          child: Text(
            data,
            style: TextStyle(
                letterSpacing: 2, fontWeight: FontWeight.w500, fontSize: 15.0),
          ),
          onTap: onTap),
    );
  }

  Widget sourashtraCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.lightBlueAccent])),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Learn concepts and\nnew technologies in',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "ꢱꣃꢬꢵꢰ꣄ꢜ꣄ꢬ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )),
    );
  }

  Widget motherCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          height: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.lightBlueAccent])),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Mother tongue is the\nlanguage of',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "heart and mind",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    SpinKitPumpingHeart(
                      size: 28,
                      color: Colors.pink[300],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget skillCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (builder) => VolunteerPage()));
        },
        child: Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Got Skills and want \nto create content in',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "ꢱꣃꢬꢵꢰ꣄ꢜ꣄ꢬ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Join us!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget materialCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: const Text('ꢱꣃꢬꢵꢰ꣄ꢜ꣄ꢬ'),
              subtitle: Text(
                'Sourashtra',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'ꢱꣃꢬꢵꢰ꣄ꢜ꣄ꢬ Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('Watch Now'),
                ),
              ],
            ),
            Image.network(
                'https://www.coderepublics.com/tools/Images/youtube-thumbnail-size.png'),
          ],
        ),
      ),
    );
  }

  Widget containerCard(String title, String url, dynamic onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          decoration: new BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            image: new DecorationImage(
              image: new NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
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

  void handleSignOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    Fluttertoast.showToast(
      msg: 'User signed out successfully!',
      textColor: Colors.black,
      backgroundColor: Colors.white,
      fontSize: 15.0,
    );
    print(await _firebaseAuth.currentUser());
    Navigator.pop(context);
    Navigator.pop(context);
    SystemNavigator.pop();
  }

  launchPrivacyPoilcy() async {
    await launch(
        "https://www.freeprivacypolicy.com/live/e502b63d-2991-4b51-b254-8872da460910");
  }
}
