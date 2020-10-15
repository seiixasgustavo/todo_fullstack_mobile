class Todo {
  int id;
  String text;
  bool isCompleted;
  DateTime due;

  Todo({
    this.id,
    this.text,
    this.isCompleted,
    this.due,
  });

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        id: json['ID'],
        text: json['text'],
        isCompleted: json['isCompleted'],
        due: DateTime.fromMillisecondsSinceEpoch(int.parse(json['due'])),
      );

  static Map<String, List<Todo>> fromJsonList(Map<String, dynamic> json) {
    Map<String, List<Todo>> res = {};
    for (final key in json.keys) {
      for (final element in json[key]) {
        if (res[key] != null) {
          res[key].add(fromJson(element));
        } else {
          res[key] = List<Todo>();
          res[key].add(fromJson(element));
        }
      }
    }
    return res;
  }

  Map<String, dynamic> toJson(int userId) => {
        'ID': this.id,
        'text': this.text,
        'isCompleted': this.isCompleted,
        'due': this.due.millisecondsSinceEpoch.toString(),
        'userId': userId
      };

  Map<String, dynamic> toJsonWithoutId(int userId) => {
        'text': this.text,
        'isCompleted': this.isCompleted,
        'due': this.due.millisecondsSinceEpoch.toString(),
        'userId': userId
      };
}
