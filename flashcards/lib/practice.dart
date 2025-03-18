import 'dart:io';
import 'package:flutter/material.dart';

class FlashcardViewer extends StatefulWidget {
  final List<File> flashcards;

  const FlashcardViewer({Key? key, required this.flashcards}) : super(key: key);

  @override
  _FlashcardViewerState createState() => _FlashcardViewerState();
}

class _FlashcardViewerState extends State<FlashcardViewer> {
  int currentIndex = 0;
  bool showAnswer = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  setState(() {}); 
}


  void _nextCard() {
    setState(() {
      if (currentIndex < widget.flashcards.length - 1) {
        currentIndex++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("All Cards, Starting from first card!!"),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 500),
          ),
        );
        currentIndex = 0;
      }
      showAnswer = false;
    });
  }

  void _toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.isEmpty) {
      return Scaffold(
        body: Center(child: Text("No Flashcards Available")),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Card ${currentIndex + 1}/${widget.flashcards.length}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<String>(
                      future: widget.flashcards[currentIndex].readAsString(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Text("No data in this card.");
                        }

                        List<String> parts = snapshot.data!.split("\n");
                        String question = parts[0].replaceFirst("Q: ", "");
                        String answer = parts.length > 1 ? parts[1].replaceFirst("A: ", "") : "No answer available";

                        return Column(
                          children: [
                            Text(
                              showAnswer ? "Answer:" : "Question:",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                            ),
                            SizedBox(height: 5),
                            Text(
                              showAnswer ? answer : question,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: _toggleAnswer,
                              icon: Icon(showAnswer ? Icons.visibility_off : Icons.visibility),
                              label: Text(showAnswer ? "Hide Answer" : "Show Answer"),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _nextCard,
                icon: Icon(Icons.arrow_forward),
                label: Text("Next Card"),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
