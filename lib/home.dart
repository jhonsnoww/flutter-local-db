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
          TextFormField(
            controller: nameController,
          ),
          TextFormField(
            controller: phoneController,
          ),
          TextFormField(
            controller: noController,
          ),
          TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search",
              contentPadding: EdgeInsets.only(left: 15),
              suffixIcon: InkWell(
                  child: Icon(Icons.search),
                  onTap: () {
                    search(searchController.text.toString());
                  }),
            ),
          ),
          RaisedButton(
              child: Text("Add"),
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
                                  title: Text(e.no.toString()),
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
