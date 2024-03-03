import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iq101/providers/auth_provider.dart';

import '../Screen/cap.dart';
import '../Screen/homescreen.dart';
import '../model/pref_status.dart';
import '../model/user_model.dart';
import '../shared_prefs.dart';




class UserService {
  // static const String baseUrl =  'http://34.212.238.163:6000/api';
  // static const String baseUrl =  'http://127.0.0.1:5000/api';
  static const String baseUrl =  'http://10.0.2.2:5000/api';
  Future<void> login(BuildContext context, String? email) async {


    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        // Uri.parse('http://10.0.2.2:5000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {


        final jsonData = json.decode(response.body);
        final user = User.fromJson(jsonData['user']);



        // Navigate to the home screen or perform any other action upon successful login
      } else {
        // Show an error message if login failed
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Login Failed'),
                content: Text('Invalid email or password.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<User?> loginSys(BuildContext context,String email, String password) async {
    // Replace 'your-api-url.com' with the actual URL of your login API
    const apiUrl = '$baseUrl/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Login successful, handle the response here
      final jsonData = json.decode(response.body);

      return User.fromJson(jsonData['user']);
    } else {
      // Login failed, handle the error here
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid email or password.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }

  }


  Future<User?> loginCredentials(String? email, String? password) async {

    // final email = _emailController.text.trim();
    // final password = _passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        // Uri.parse('http://10.0.2.2:5000/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password' : password}),
      );

      if (response.statusCode == 200) {


        final jsonData = json.decode(response.body);
        final user = User.fromJson(jsonData['user']);

        await SharedPrefs().addMapPrefs(
          'userdetails',
          user.toJson(),
        );

       return user;

        // Navigate to the home screen or perform any other action upon successful login
      }

    } catch (e) {
      print('Error: $e');
    }
  }

  Future<User?> register(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    final url = Uri.parse('$baseUrl/register');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'name': name,
      'email': email,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return User.fromJson(responseData['user']);
    } else {
      return null;
    }
  }
}