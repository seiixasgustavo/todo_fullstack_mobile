import 'dart:ffi';

class Todo {
  Uint64 id;
  String text;
  bool isCompleted;
  DateTime due;

  Todo({
    this.id,
    this.text,
    this.isCompleted,
    this.due,
  });

  Todo fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        text: json['text'],
        isCompleted: json['isCompleted'],
        due: json['due'],
      );
  Map<String, dynamic> toJson() => {
        'id': this.id,
        'text': this.text,
        'isCompleted': this.isCompleted,
        'due': this.due.millisecondsSinceEpoch,
        'userId': 1
      };
}
