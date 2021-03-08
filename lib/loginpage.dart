import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learnable/homepage.dart';
import 'package:learnable/welcomepage.dart';
import 'userdetails.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  //Google Sign-In Instance
  //
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //
  //Firebase Authentication Instance
  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  //Firestore User Collection Reference
  CollectionReference userCollectionRef =
      Firestore.instance.collection("Users");

  bool loggedInAlready = false;

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginScreen(),
    );
  }

  Widget loginScreen() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/learnable.png",
            scale: 4,
          ),
          Text(
            "Login to Start",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
//          Padding(
//            padding: const EdgeInsets.all(20.0),
//            child: Center(
//              child: Text(
//                "Expand your Perception with AudioPortal",
//                style: TextStyle(fontSize: 15.0, letterSpacing: 2),
//              ),
//            ),
          //    ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: !loggedInAlready
                    ? RaisedButton(
                        splashColor: Colors.blue,
                        color: Colors.blue,
                        onPressed: () {
                          _handleSignIn();
                        },
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/googlelogopng.png",
                                scale: 70,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "LOGIN WITH GOOGLE",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    : showLoading(),
              ),
              termsAndCondition()
            ],
          ),

          Text("© 2021 SouLearn")
        ],
      ),
    );
  }

  //
  //Function to handle Sign In
  //
  void _handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    print("Sign In with Google Succeeded : $user");

    UserDetails userDetails = UserDetails(
        userEmail: user.email,
        userName: user.displayName,
        photoUrl: user.photoUrl,
        providerDetails: user.providerId,
        userUID: user.uid);

    userCollectionRef
        .document(userDetails.userUID)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.exists && ds['userName'] != null) {
        setState(() async {
          print('Data Exists');
          await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => HomePage(
                      userDetails: userDetails,
                    )),
          );
        });
      } else {
        setState(() async {
          await Firestore.instance
              .collection('Users')
              .document('${userDetails.userUID}')
              .setData({
            'userName': '${userDetails.userName}',
            'userUid': '${userDetails.userUID}',
            'userMail': '${userDetails.userEmail}',
            'userPhotoURL': '${userDetails.photoUrl}',
            'joinDate': DateTime.now().toString(),
            'renewalDate': DateTime.now().add(Duration(days: 15)).toString(),
          }).whenComplete(await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (builder) =>
                    new WelcomePage(userDetails: userDetails)),
          ));
          print('New User Data Created');
        });
      }
    });
  }

  checkUserLogin() async {
    if (await _firebaseAuth.currentUser() != null) {
      Fluttertoast.showToast(
          msg: "User already logged in", timeInSecForIosWeb: 2);
      _handleSignIn();
    }
  }

  getInterestDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog();
        });
  }

  Widget showLoading() {
    return SpinKitPulse(
      color: Colors.orange,
      size: 50.0,
    );
  }

  Widget termsAndCondition() {
    return FlatButton(
        onPressed: () {
          launchPrivacyPoilcy();
        },
        child: Text(
          "By Logging in you agree to Privacy Policy",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blueAccent,
            fontSize: 12,
          ),
        ));
  }

  launchPrivacyPoilcy() async {
    await launch(
        "https://www.freeprivacypolicy.com/live/e502b63d-2991-4b51-b254-8872da460910");
  }
}
