import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flashcards/all_cards.dart';
import 'package:flashcards/practice.dart';
import 'package:flutter/material.dart';

// Defining own theme colors used in all files
class AppColors {
  static const Color violet = Color(0xFF5B4494);
  static const Color lightPurple = Color(0xFFEBDDFF);
}

// HomeScreen Class 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<File> flashcardFiles = [];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

// Future function to load all the flashcards from the saved files
  Future<void> _loadFlashcards() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith(".txt"))
        .toList();
    
    setState(() {
      flashcardFiles = files;
    });
  }

// Function defining what to do on clicking on different children of bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // if the index is 0 it means practice mode is on so always reload the flashcards available and their modified data
      if (index == 0) {
        _loadFlashcards();  
      }
    });
  }


// build function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FlashCard App",
          style: TextStyle(color: AppColors.violet),
        ),
        backgroundColor: AppColors.lightPurple,
        centerTitle: true,
      ),
      // body contains a ternary statement to either load practice screen or card menu depending upon the bottom navigation bar setting, 
      // initially on loading the app practice screen is opened by default
      body: _selectedIndex == 0 
        ? FlashcardViewer(flashcards: flashcardFiles)
        : AllCards(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: "Cards"),
          BottomNavigationBarItem(icon: Icon(Icons.psychology_sharp), label: "Practice"),
        ],
      ),
    );
  }
}