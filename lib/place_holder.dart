import 'package:flutter/material.dart';

class MyPlaceHolder extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
      ),
    );
  }
}
