import 'package:flutter/material.dart';
import 'package:mini_blog/screens/homepage.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}
