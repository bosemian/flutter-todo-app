import 'package:flutter/material.dart';
import './add_todo.dart';
import './todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore db = Firestore.instance;
  List<Todo> todos = List<Todo>();

  void _viewAddTodo() async {
    final newTodo = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddTodo()));
    // todos.add(Todo(isChecked: false, name: newTodo));
  }

  _buildRow(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todos').orderBy("isDone").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    todos = snapshot.map((documentSnapshot) => Todo.fromSnapshot(documentSnapshot)).toList();
    return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, position) {

            return Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(todos[position].title, style: TextStyle(fontSize: 24.0, decoration: todos[position].isDone ? TextDecoration.lineThrough : TextDecoration.none ))),
                    Checkbox(
                        value: todos[position].isDone,
                        onChanged: (bool value) {
                          setState(() {
                            db.collection("todos").document(todos[position].id).setData({'isDone': value, 'title': todos[position].title});
                            todos[position].isDone = value;
                          });
                        })
                  ],
                ));
          },
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
        ),
        body: _buildRow(context),
        floatingActionButton: FloatingActionButton(
          onPressed: _viewAddTodo,
          tooltip: 'Compose Email',
          child: Icon(Icons.add),
        ),
      );
  }
}