import 'package:flashcards/home.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String text;
  final VoidCallback onDelete;
  final VoidCallback onClicked;

  const CustomCard({
    required this.text,
    required this.onDelete,
    required this.onClicked,
    super.key,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: widget.onClicked,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(color: AppColors.violet, fontSize: 20.0),
                  ),
                  Text(
                    "Question",
                    style: TextStyle(color: AppColors.violet, fontSize: 20.0),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Positioned(
              top: 0.1,
              right: 0.1,
              child: IconButton(
                color: AppColors.lightPurple,
                icon: Icon(Icons.delete, color: AppColors.violet),
                onPressed: widget.onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
