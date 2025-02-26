import 'package:flashcards/custom_practice_card.dart';
import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  List<String> flashcards = ["Card 1", "Card 2"]; // Initial flashcards


  void addCard() {
    setState(() {
      flashcards.add("Card ${flashcards.length + 1}");
    });
  }

  void deleteCard(int index) {
    setState(() {
      flashcards.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3 / 2, // Adjust height & width ratio
          ),
          itemCount: flashcards.length,
          itemBuilder: (context, index) {
            return CustomCard(
              text: flashcards[index],
              onDelete: () => deleteCard(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCard,
        child: Icon(Icons.add),
        // backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
