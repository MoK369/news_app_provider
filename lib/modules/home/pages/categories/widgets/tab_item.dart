import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;
  final String title;

  const TabItem({super.key, required this.isSelected, required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: theme.cardColor, width: 3),
            borderRadius: BorderRadius.circular(25),
            color: isSelected ? theme.cardColor : Colors.transparent,
            shape: BoxShape.rectangle),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.exo(
                color: isSelected ? Colors.white : theme.cardColor,
                fontWeight: FontWeight.w400,
                fontSize: 20),
          ),
        ));
  }
}
