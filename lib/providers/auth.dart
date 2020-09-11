import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_mobile_fullstack/models/user.dart';
import 'package:todo_mobile_fullstack/utils/http_exception.dart';
import 'package:todo_mobile_fullstack/utils/url.dart';

class Auth with ChangeNotifier {
  String _token;
  User _user;
  DateTime _expiryDate;

  bool get isAuth => _token != null;
  User get user =>
      _user != null ? _user : User(1, 'gustavo@gustavo.com', 'Gustavo Nabak');
  String get token => _token;

  Future<void> login(String email, String password) async {
    print('login');
    final url = '$authUrl/login';
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _user = User(
        responseData['User']['ID'],
        responseData['User']['email'],
        responseData['User']['name'],
      );
      _token = responseData['Token'];
      //_expiryDate = responseData['expiryDate'];
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', json.encode(_user.toJson()));
      prefs.setString('token', _token);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> signUp(String name, String password, String email) async {
    final url = '$authUrl/signup';
    print('$name $password $email');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'name': name, 'password': password}),
      );
      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      return responseData['Status'];
    } catch (e) {
      throw e;
    }
  }
}
