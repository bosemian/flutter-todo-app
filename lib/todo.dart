import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  bool isDone;
  String title;
  String id;

  Todo({this.id, this.title, this.isDone});

 Todo.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    isDone = snapshot.data['isDone'];
  } 
}