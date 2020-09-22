import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localdb/model/msg.dart';

class MessageWidget extends StatefulWidget {
  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Msg> ls = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage :: $message");
        final noti = message['notification'];
        ls.add(Msg(title: noti['title'], body: noti['body']));
        setState(() {});
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch :: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume :: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: ls
            .map((e) => ListTile(
                  title: Text(e.title),
                  subtitle: Text(e.body),
                ))
            .toList(),
      ),
    );
  }
}
