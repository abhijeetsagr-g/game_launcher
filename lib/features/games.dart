import 'package:flutter/material.dart';
import 'package:game_launcher/features/db_helper.dart';

class Games {
  int id;
  String title;
  String command;
  String path;

  Games({
    required this.id,
    required this.title,
    this.command = "",
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "command": command, "path": path};
  }

  factory Games.fromMap(Map<String, dynamic> map) {
    return Games(
      id: map['id'] as int,
      title: map['title'] as String,
      command: map['command'] as String,
      path: map['path'] as String,
    );
  }
}

class GameList with ChangeNotifier {
  List<Games> _gamesList = [];
  List<Games> get gamesList => _gamesList;

  final db = DatabaseHelper();

  Future<void> loadList() async {
    final loadedTasks = await db.getList();
    _gamesList = loadedTasks;
    notifyListeners();
  }

  Future<void> addGame(Games game) async {
    db.insertGame(game);
    loadList();
  }

  Future<void> deleteGame(int id) async {
    db.deleteGame(id);
    loadList();
  }
}
