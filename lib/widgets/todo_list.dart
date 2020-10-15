import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_fullstack/models/todo.dart';
import 'package:todo_mobile_fullstack/providers/todos.dart';
import 'package:todo_mobile_fullstack/widgets/todo_tile.dart';

class TodoList extends StatefulWidget {
  final DateTime selectedTime;

  TodoList({this.selectedTime});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Future<void> deleteTodo(BuildContext context, Todo todo) async {
    try {
      await Provider.of<Todos>(context, listen: false).deleteTodo(todo);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateTodo(BuildContext context, Todo todo, bool value) async {
    try {
      Todo newTodo = todo;
      newTodo.isCompleted = value;
      await Provider.of<Todos>(context, listen: false)
          .updateTodo(todo, newTodo);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String selectedDate =
        '${widget.selectedTime.year}-${widget.selectedTime.month}-${widget.selectedTime.day}';
    return Consumer<Todos>(
      builder: (context, value, child) => ListView.builder(
        itemCount: value.todosCount(selectedDate) != null
            ? value.todosCount(selectedDate)
            : 0,
        itemBuilder: (context, int index) => TodoTile(
          todo: value.todos[selectedDate][index],
          onDismiss: deleteTodo,
          onUpdate: updateTodo,
        ),
      ),
    );
  }
}
