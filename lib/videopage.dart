import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

class ChewieDemo extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  dynamic firebaseDocument;
  ChewieDemo({this.firebaseDocument});

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;

  ChewieController _chewieController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Wakelock.enable();
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    Wakelock.disable();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.firebaseDocument['videoURL']);
    await _videoPlayerController1.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      // Try playing around with some of these other options:
      allowedScreenSleep: false,
      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),

      // autoInitialize: true,
    );

    setState(() {});
  }

  Widget _portraitView() {
    print("Portrait View");
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.blue[100],
                  height: MediaQuery.of(context).size.height * 0.275,
                  child: _chewieController != null &&
                          _chewieController
                              .videoPlayerController.value.initialized
                      ? Chewie(
                          controller: _chewieController,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SpinKitPumpingHeart(
                                color: Colors.blue,
                                size: 60.0,
                              ),
                            )
                          ],
                        ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _chewieController.enterFullScreen();
                            },
                            child: Text(
                              'Watch on Fullscreen',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.firebaseDocument['title'],
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.firebaseDocument['subtitle'],
                                style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.firebaseDocument['domain']
                                        .toString()
                                        .substring(0, 1)
                                        .toUpperCase() +
                                    widget.firebaseDocument['domain']
                                        .toString()
                                        .substring(1),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                    widget.firebaseDocument['bigdescription'])),
                          ),
                        ],
                      ),
                    ),
                    motherCard(),
                    Image.asset('assets/images/alphapngnew.png')
                  ],
                ),
              ]),
        ),
      );
    });
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

  Widget _landscapeView() {
    print("Landscape View");
    // _chewieController.enterFullScreen();
    // sleep(Duration(microseconds: 10));
    return Chewie(
      controller: _chewieController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Video",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(child: _portraitView()),
    );
  }
}
