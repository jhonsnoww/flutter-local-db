import 'package:flutter/material.dart';
import 'package:flutter_localdb/message.dart';

import 'custom_input.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local DB',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Local DB'),
          ),
          body: MessageWidget()),
    );
  }
}
