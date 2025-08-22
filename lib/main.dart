import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_launcher/features/games.dart';
import 'package:game_launcher/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => GameList(),
      child: MaterialApp(
        title: 'One way to Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorSchemeSeed: Colors.blueAccent),
        home: Home(),
      ),
    ),
  );
}
