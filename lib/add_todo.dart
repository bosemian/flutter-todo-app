import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _addController = TextEditingController();

  void _handleAddTodo(String value) {
    _addController.clear();
    Navigator.pop(context, value);
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
