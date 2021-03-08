import 'package:flutter/material.dart';
import 'package:learnable/videopage.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class VideoListPage extends StatefulWidget {
  final String domain;
  VideoListPage({@required this.domain});
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  bool loadingState = true;
  CollectionReference videoCollRef = Firestore.instance.collection("Videos");
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        loadingState = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.domain.substring(0, 1).toUpperCase() +
              widget.domain.substring(1)),
        ),
        body: loadingState ? shimmerPlaceHolder() : bodyContent());
  }

  Widget bodyContent() {
    return queryStream();
  }

  Widget materialCard(String title, String subtitle, String description,
      String imageURL, dynamic document) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                child: Icon(Icons.play_circle_filled),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (builder) => new ChewieDemo(
                                firebaseDocument: document,
                              )));
                },
              ),
              title: Text(title),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  textColor: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (builder) => new ChewieDemo(
                                  firebaseDocument: document,
                                )));
                  },
                  child: const Text('Watch Now'),
                ),
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.26,
                child: Image.network(imageURL)),
          ],
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
          VideoShimmer(),
          VideoShimmer(),
          VideoShimmer(),
          VideoShimmer()
        ],
      ),
    );
  }

  Widget queryStream() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          videoCollRef.where("domain", isEqualTo: widget.domain).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null || snapshot.data.documents.length == 0) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "NOTHING TO",
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("SHOW! 🙄",
                    style: TextStyle(
                      color: Colors.grey[800],
                      letterSpacing: 2,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          );
        }
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: SpinKitPulse(
                color: Colors.blue,
                size: 70,
              ),
            );

          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return materialCard(
                    document['title'],
                    document['subtitle'],
                    document['smalldescription'],
                    document['pictureURL'],
                    document);
              }).toList(),
            );
        }
      },
    );
  }
}
