import 'dart:ffi';

class User {
  int id;
  String email;
  String name;

  User(this.id, this.email, this.name);

  Map<String, dynamic> toJson() => {'ID': id, 'email': email, 'name': name};
  User fromJson(Map<String, dynamic> json) => User(
        json['ID'],
        json['email'],
        json['name'],
      );
}
