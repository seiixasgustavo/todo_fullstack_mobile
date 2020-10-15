import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_mobile_fullstack/models/todo.dart';
import 'package:todo_mobile_fullstack/utils/http_exception.dart';
import 'package:todo_mobile_fullstack/utils/url.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Todos with ChangeNotifier {
  Map<String, List<Todo>> _todos = {};

  Map<String, List<Todo>> get todos => _todos;

  int todosCount(String selectedDate) =>
      _todos[selectedDate] != null ? _todos[selectedDate].length : 0;

  Future<void> getAllTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final user = prefs.getString('userData');
    final userData = await json.decode(user);

    final url = '$todoUrl/find/user/timestamp/${userData['ID']}';
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        _todos = Todo.fromJsonList((responseData['Todos'] as Map));
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addTodo(Todo todo) async {
    final url = '$todoUrl/create';
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final user = prefs.getString('userData');
      final userData = await json.decode(user);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(todo.toJsonWithoutId(userData['ID'])),
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        todo.id = responseData['ID'];
        String d = '${todo.due.year}-${todo.due.month}-${todo.due.day}';
        if (_todos[d] == null) {
          _todos[d] = List<Todo>();
        }
        _todos[d].add(todo);
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateTodo(Todo todo, Todo newTodo) async {
    final url = '$todoUrl/update/${todo.id}';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final user = prefs.getString('userData');
      final userData = await json.decode(user);

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(newTodo.toJson(userData['ID'])),
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        String d = '${todo.due.year}-${todo.due.month}-${todo.due.day}';
        int index = _todos[d].indexOf(todo);
        _todos[d][index] = newTodo;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    final url = '$todoUrl/delete/${todo.id}';

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (responseData['Status'] == true) {
        String d = '${todo.due.year}-${todo.due.month}-${todo.due.day}';
        _todos[d].remove(todo);
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  void logout() {
    _todos.clear();
    notifyListeners();
  }
}
