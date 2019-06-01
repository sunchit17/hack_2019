import 'package:flutter/material.dart';
import './login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Github Search',
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}
