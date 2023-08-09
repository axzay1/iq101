import 'package:flutter/material.dart';

import '../model/user_model.dart';



class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.name}'),
            SizedBox(height: 16.0),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}