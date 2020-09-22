import 'package:flutter/material.dart';
import 'package:flutter_localdb/service/db.dart';

import 'model/note.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> notes;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var noController = TextEditingController();
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Name",
                  contentPadding: EdgeInsets.only(left: 20)),
              controller: nameController,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Phone",
                  contentPadding: EdgeInsets.only(left: 20)),
              controller: phoneController,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon:
                      IconButton(icon: Icon(Icons.scanner), onPressed: () {}),
                  // suffix:
                  //     IconButton(icon: Icon(Icons.scanner), onPressed: () {}),
                  hintText: "Lot Number",
                  contentPadding: EdgeInsets.only(left: 20)),
              controller: noController,
            ),
          ),
          RaisedButton(
              color: Colors.blue.shade500,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                Note note = Note();
                note.name = nameController.text.toString();
                note.phone = phoneController.text.toString();
                note.no = int.parse(noController.text.toString());
                await DB().add(note);
                refresh();
              }),
          Expanded(
              child: notes != null
                  ? ListView(
                      children: notes
                          .map((e) => Card(
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text(e.no.toString()),
                                      Text(e.created_at.toString()),
                                    ],
                                  ),
                                  subtitle: Text(e.name),
                                  trailing: FlatButton.icon(
                                      label: Text(e.phone),
                                      icon: Icon(
                                        Icons.phone,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {}),
                                ),
                              ))
                          .toList(),
                    )
                  : Text("No Notes"))
        ],
      ),
    );
  }

  Future<void> search(s) async {
    notes = await DB().searchNotes(s);
    setState(() {});
  }

  Future<void> refresh() async {
    notes = await DB().getNotes();
    setState(() {});
  }
}
