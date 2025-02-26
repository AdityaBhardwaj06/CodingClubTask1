import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String text;
  final VoidCallback onDelete;

   const CustomCard({required this.text, required this.onDelete, Key? key}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  
  
  @override
  Widget build(BuildContext context) {
    return Card(
              color: const Color.fromARGB(212, 82, 38, 203),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          widget.text,
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Question",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Answer",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 5.0,
                    right: 5.0,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed:widget.onDelete,
                    ),
                  ),
                ],
              ),
            );
  }
}