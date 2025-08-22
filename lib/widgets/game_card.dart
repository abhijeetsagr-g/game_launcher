import 'dart:io';
import 'package:flutter/material.dart';
import 'package:game_launcher/features/games.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.game});
  final Games game;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => print("Hello world"),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: game.path.isNotEmpty
                    ? Image.file(File(game.path), fit: BoxFit.cover)
                    : const Icon(
                        Icons.videogame_asset,
                        size: 64,
                        color: Colors.grey,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  game.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
