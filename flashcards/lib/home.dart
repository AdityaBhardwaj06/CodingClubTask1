import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flashcards/all_cards.dart';
import 'package:flashcards/practice.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color violet = Color(0xFF5B4494);
  static const Color lightPurple = Color(0xFFEBDDFF);
}

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _loadFlashcards(); // Reload flashcards when switching to "Cards"
      }
    });
  }

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
      body: _selectedIndex == 0 
        ? FlashcardViewer(flashcards: flashcardFiles)
        : AllCards(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.psychology_sharp), label: "Practice"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: "Cards"),
          
        ],
      ),
    );
  }
}