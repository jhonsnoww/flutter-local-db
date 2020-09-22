import 'package:flutter/material.dart';
import 'package:flutter_localdb/place_holder.dart';

class CustomInput extends StatefulWidget {
  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  List<MyPlaceHolder> ls = [];
  void onAdd() {
    ls.add(MyPlaceHolder());

    setState(() {});
  }

  void onRemove() {
    if (ls.length > 1) {
      ls.removeLast();

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    onAdd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.amber,
            constraints:
                BoxConstraints(maxHeight: double.infinity, minHeight: 40),
            child: ListView.builder(
              itemCount: ls.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, idx) {
                return Column(
                  children: [
                    ls[idx],
                    idx == ls.length - 1
                        ? Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                        onPressed: () {
                                          onAdd();
                                        },
                                        child: Text("Add ")),
                                    RaisedButton(
                                        onPressed: onRemove,
                                        child: Text("remove "))
                                  ],
                                ),
                                RaisedButton(
                                    onPressed: () {
                                      for (var con in ls) {
                                        print(
                                            "Result :::" + con.controller.text);
                                      }
                                    },
                                    child: Text("OnSubmit"))
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
