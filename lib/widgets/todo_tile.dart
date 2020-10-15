import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_fullstack/models/todo.dart';
import 'package:todo_mobile_fullstack/providers/todos.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final Function onDismiss;
  final Function onUpdate;

  TodoTile({this.todo, this.onDismiss, this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todo.id),
      background: Container(
        color: Colors.red,
        child: Icon(FontAwesomeIcons.times),
      ),
      child: ListTile(
        title: Text(todo.text),
        trailing: Checkbox(
          activeColor: Colors.blueAccent,
          value: todo.isCompleted,
          onChanged: (value) {
            onUpdate(context, todo, value);
          },
        ),
      ),
      onDismissed: (direction) {
        onDismiss(context, todo);
      },
    );
  }
}
