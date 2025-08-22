import 'dart:io';
import 'package:flutter/material.dart';
import 'package:game_launcher/features/games.dart';
import 'package:provider/provider.dart';

void showAddGameDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: const AddGame(),
        ),
      );
    },
  );
}

class AddGame extends StatefulWidget {
  const AddGame({super.key});

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController commandController = TextEditingController();
  String savePath = "";
  File? _iconFile;

  Future<void> _pickFile() async {
    try {
      final result = await Process.run('zenity', [
        '--file-selection',
        '--file-filter=*.png',
      ]);

      if (result.exitCode == 0) {
        final path = (result.stdout as String).trim();
        if (path.isNotEmpty) {
          setState(() {
            _iconFile = File(path);
            savePath = path;
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Zenity not found. Please install it.")),
      );
    }
  }

  void onSave() {
    if (titleController.text.isEmpty || commandController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    final gameList = Provider.of<GameList>(context, listen: false);
    Games newGame = Games(
      title: titleController.text,
      command: commandController.text,
      path: savePath,
      id: gameList.gamesList.length + 1,
    );

    gameList.addGame(newGame);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const Text(
              "Add New Game",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 20),

            // Game title
            const Text(
              "Game Title",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: "Enter game title",
              ),
            ),

            const SizedBox(height: 20),

            // Command
            const Text(
              "Executable Command",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: commandController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: "echo 'command'",
              ),
            ),

            const SizedBox(height: 20),

            // Game Icon
            const Text(
              "Game Icon",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Thumbnail
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _iconFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_iconFile!, fit: BoxFit.cover),
                        )
                      : const Icon(Icons.image, size: 32, color: Colors.grey),
                ),
                const SizedBox(width: 16),

                // Upload button
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Upload Icon"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
