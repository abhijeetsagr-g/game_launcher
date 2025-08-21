import 'package:flutter/material.dart';
import 'package:game_launcher/screens/home.dart';

void main() => runApp(
  MaterialApp(
    title: 'One way to Game',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.blueAccent),
    home: Home(),
  ),
);
