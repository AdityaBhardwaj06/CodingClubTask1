import 'package:flashcards/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CardDisplay extends StatefulWidget {
  final File? file;
  final int cardNumber;
  const CardDisplay({super.key, this.file, required this.cardNumber});

  @override
  State<CardDisplay> createState() => CardDisplayState();
}

class CardDisplayState extends State<CardDisplay> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.file != null) {
      _loadCardData();
    }
  }

  Future<void> _loadCardData() async {
    final content = await widget.file!.readAsString();
    final parts = content.split("\n");
    if (parts.length >= 2) {
      _questionController.text = parts[0].replaceFirst("Q: ", "");
      _answerController.text = parts[1].replaceFirst("A: ", "");
    }
  }

  Future<File?> _saveFlashcard() async {
    String question = _questionController.text.trim();
    String answer = _answerController.text.trim();

    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Question & Answer cannot be empty!!"), backgroundColor: Colors.red,duration: Duration(milliseconds: 500 ),),
      );
      return null;
    }

    final directory = await getApplicationDocumentsDirectory();
    final file =
        widget.file ??
        File(
          '${directory.path}/card_${DateTime.now().millisecondsSinceEpoch}.txt',
        ); // Ensure unique filename

    await file.writeAsString("Q: $question\nA: $answer");
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card ${widget.cardNumber}", style: TextStyle(color: AppColors.violet),),
        actions: [
          IconButton(
            onPressed: () async {
              final file = await _saveFlashcard();
              if (file != null) {
                Navigator.pop(context, file);
              }
            },
            icon: Icon(Icons.done, color: AppColors.violet),
          ),
        ],
        backgroundColor: AppColors.lightPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _questionController,
              textAlign: TextAlign.center,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Question",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _answerController,
              textAlign: TextAlign.center,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Answer",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final file = await _saveFlashcard();
                if (file != null) {
                  Navigator.pop(context, file);
                }
              },
              icon: Icon(Icons.save, color: AppColors.violet),
              label: Text("Save Card", style: TextStyle(color: AppColors.violet)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
