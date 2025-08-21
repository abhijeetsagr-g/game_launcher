import 'package:flutter/material.dart';
import 'package:game_launcher/screens/add_game.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final pages = [
    Center(child: Text("All games")),
    Center(child: Text("Favourites")),
    Center(child: Text("Recently Played")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            elevation: 4,
            backgroundColor: Colors.grey[100],
            extended: true,
            labelType: NavigationRailLabelType.none,
            selectedIndex: _currentIndex,
            onDestinationSelected: (value) => setState(() {
              _currentIndex = value;
            }),
            // indicatorColor: Colors.blueAccent,
            destinations: [
              NavigationRailDestination(
                padding: EdgeInsets.only(left: 10),
                icon: Icon(Icons.apps),
                label: Text("All Games"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_outline),
                label: Text("Favorite"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                label: Text("Recently played"),
              ),
            ],
          ),

          Expanded(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Game Launcher",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        width: 300,
                        child: TextField(
                          maxLength: 20,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            counterText: "",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Search games...",
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          fixedSize: Size(150, 45),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          "Add Game",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "NotoSans",
                          ),
                        ),
                        onPressed: () {
                          showAddGameDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
                Expanded(child: pages[_currentIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
