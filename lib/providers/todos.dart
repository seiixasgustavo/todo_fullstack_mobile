import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_mobile_fullstack/models/todo.dart';
import 'package:todo_mobile_fullstack/utils/http_exception.dart';
import 'package:todo_mobile_fullstack/utils/url.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Todos with ChangeNotifier {
  List<Todo> _todos;

  List<Todo> get todos => _todos;

  int get todosCount => _todos.length;

  Future<void> addTodo(Todo todo) async {
    final url = '$todoUrl/create';
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print(todo.toJson());
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(todo.toJson()),
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        todo.id = responseData['ID'];
        _todos.add(todo);
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateTodo(Todo todo, Todo newTodo) async {
    final url = '$todoUrl/update/:${todo.id}';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode(todo),
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        int index = _todos.indexOf(todo);
        _todos[index] = newTodo;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    final url = '$todoUrl/delete/:${todo.id}';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        url,
        headers: {'Authorization': token},
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        _todos.remove(todo);
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }
}
