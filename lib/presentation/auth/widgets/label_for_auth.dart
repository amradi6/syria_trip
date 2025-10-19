import 'package:flutter/material.dart';

class LabelForAuth extends StatelessWidget {
  const LabelForAuth({super.key, required this.size, required this.text});

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: size.width * 0.041),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    );
  }
}
