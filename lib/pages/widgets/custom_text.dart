import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  const CustomText(
      {super.key,
      required this.text,
      required this.size,
      required this.color,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text, 
        style: TextStyle(
          color: color, 
          fontSize: size, 
          fontWeight: weight,
        ),
      ),
    );
  }
}
