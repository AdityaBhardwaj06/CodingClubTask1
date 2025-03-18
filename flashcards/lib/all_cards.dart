import 'package:flashcards/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flashcards/custom_card.dart';
import 'package:flashcards/card_display.dart';

class AllCards extends StatefulWidget {
  const AllCards({super.key});

  @override
  AllCardsState createState() => AllCardsState();
}

class AllCardsState extends State<AllCards> {
  // list to store addresses of all flashcards
  List<File> flashcardFiles = [];

  @override
  Future<void> initState() async {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    final directory = await getApplicationDocumentsDirectory();
    final files =
        directory
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith(".txt"))
            .toList();
    setState(() {
      flashcardFiles = files;
    });
  }

  // function to create a new card in the list
  void addCard() async {
  final newFile = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CardDisplay(cardNumber: flashcardFiles.length + 1)),
  );
  if (newFile != null) {
    setState(() {
      flashcardFiles.add(newFile);
    });
  }
  await _loadFlashcards(); 
}

  // deletees a card from the list and its save file
  void deleteCard(int index) {
    setState(() {
      flashcardFiles[index].deleteSync();
      flashcardFiles.removeAt(index);
    });
  }

  // opens a card which can be modified
  void openCard(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                CardDisplay(file: flashcardFiles[index], cardNumber: index + 1),
      ),
    );
    _loadFlashcards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: flashcardFiles.length,
          itemBuilder: (context, index) {
            return CustomCard(
              text: "Card ${index + 1}",
              onDelete: () => deleteCard(index),
              onClicked: () => openCard(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCard,
        backgroundColor: AppColors.lightPurple,
        child: Icon(Icons.add),
        
      ),
      
    );
  }
}
