import 'package:flutter/material.dart';
import 'userdetails.dart';
import 'package:slimy_card/slimy_card.dart';

class WelcomePage extends StatefulWidget {
  final UserDetails userDetails;
  WelcomePage({@required this.userDetails});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "App 📱 Install \nkerathako dhannu!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "User Registered Successfully! 🥳",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20.0),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "🙏",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 100.0),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            purposeCard(),
                            Center(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Continue 🤟",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))));
        }));
  }

  Widget purposeCard() {
    return SlimyCard(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width * 0.9,
      topCardHeight: 150,
      bottomCardHeight: 220,
      borderRadius: 15,
      topCardWidget: myWidget01(),
      bottomCardWidget: myWidget02(),
      slimeEnabled: true,
    );
  }

  Widget myWidget01() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "What's the purpose of this App? 🤔",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget myWidget02() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "The Ultimate Purpose of this app is to deliver knowledge and content in Sourashtra. We believe that this will help our language to thrive further. To Proceed further click the Continue button below and login again",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
