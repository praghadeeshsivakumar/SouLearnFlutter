import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';

class VolunteerPage extends StatefulWidget {
  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  var url = 'https://www.instagram.com/learnableindia/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Volunteer"),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      backGroundColor: Colors.blueAccent,
                      child: Text(
                        "Have you ever thought of doing something for our community, but don't know how? 🤨 \nWell, This could be a platform to give back to our community 🤩",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Colors.blue,
                      child: Text(
                        "Sounds good 😍, but how could I contribute?",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      backGroundColor: Colors.blueAccent,
                      child: Text(
                        "Literally, you can create content on any skills you have, it can be making Maths, Physics, Chemistry concepts in Sourashtra for Kids or new technologies like Blockchain, IoT, ML, AI, etc 🤷‍♂️",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Colors.blue,
                      child: Text(
                        "What if I'm not technically oriented but have skills on domains like Finance, Stock Market, Entrepreneurship? 🤔",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      backGroundColor: Colors.blueAccent,
                      child: Text(
                        "You can create content on those too!",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Colors.blue,
                      child: Text(
                        "Great 😎, Are there any ways I can contribute to development of the app?",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      backGroundColor: Colors.blueAccent,
                      child: Text(
                        "🔥 Yes you can join our development team to develop the App. SouLearn's tech stack includes Flutter, NodeJs, Python and Cloud Services include Firebase and IBM Cloud. Even if you are proficient with any other technologies you are most welcomed.",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper:
                          ChatBubbleClipper3(type: BubbleType.receiverBubble),
                      backGroundColor: Colors.blue,
                      child: Text(
                        "I'm excited about this! 🥳",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatBubble(
                      clipper: ChatBubbleClipper3(type: BubbleType.sendBubble),
                      backGroundColor: Colors.blueAccent,
                      child: Text(
                        "Great, What are you waiting for? Click the below button and DM us. If you have any other suggesstions in which you can help the team, do DM us. Most Importatly share this app with your friends and family 💯. I appreciate your patience for reading this thread! 😅",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: FlatButton(
                        onPressed: () async {
                          if (await canLaunch(url)) {
                            await launch(
                              url,
                              universalLinksOnly: true,
                            );
                          } else {
                            throw 'There was a problem to open the url: $url';
                          }
                        },
                        child: Text(
                          "I'm Interested 🙋‍♂️",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
