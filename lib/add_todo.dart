import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _addController = TextEditingController();
  Firestore db = Firestore.instance;

  void _handleAddTodo(String value) {
    _addController.clear();
    var data = new Map<String, dynamic>();
    data['title'] = value;
    data['isDone'] = false;
    db.collection('todos').add(data);
    Navigator.pop(context, data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
              style: TextStyle(fontSize: 24.0,color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Todo Here...'),
                  controller: _addController,
              onSubmitted: _handleAddTodo,
            )
        ))
    );
  }
}
