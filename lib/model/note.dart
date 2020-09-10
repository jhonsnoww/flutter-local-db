class Note {
  int id;
  String name;
  String phone;
  int no;
  DateTime created_at;

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    no = map['no'];
    created_at = map['created_at'];
  }

  toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'no': no,
      'created_at': created_at
    };
  }
}
