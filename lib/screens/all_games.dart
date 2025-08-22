import 'package:flutter/material.dart';
import 'package:game_launcher/features/games.dart';
import 'package:game_launcher/widgets/game_card.dart';

import 'package:provider/provider.dart';

class AllGames extends StatefulWidget {
  const AllGames({super.key});

  @override
  State<AllGames> createState() => _AllGamesState();
}

class _AllGamesState extends State<AllGames> {
  // final games = context.watch<GameList>().gamesList;

  @override
  Widget build(BuildContext context) {
    final gamesList = Provider.of<GameList>(context, listen: true);
    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: gamesList.gamesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          final game = gamesList.gamesList[index];
          return GameCard(game: game);
        },
      ),
    );
  }
}
