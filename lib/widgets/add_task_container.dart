import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_fullstack/models/todo.dart';
import 'package:todo_mobile_fullstack/providers/todos.dart';

class AddTaskContainer extends StatefulWidget {
  final Function callback;

  AddTaskContainer(this.callback);

  @override
  _AddTaskContainerState createState() => _AddTaskContainerState();
}

class _AddTaskContainerState extends State<AddTaskContainer> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String newTaskTitle;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) selectedTime = picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'What is your task?',
              border: InputBorder.none,
            ),
            textAlign: TextAlign.start,
            autofocus: true,
            onChanged: (value) {
              newTaskTitle = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 5.0, bottom: 15.0, top: 5.0, right: 5.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.calendar_today, size: 20.0),
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.alarm, size: 20.0),
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    Provider.of<Todos>(context, listen: false).addTodo(Todo(
                      text: newTaskTitle,
                      isCompleted: false,
                      due: selectedDate,
                    ));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.send, size: 22.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
