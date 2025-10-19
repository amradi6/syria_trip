import 'package:flutter/material.dart';

class InputFiledForAuth extends StatelessWidget {
  const InputFiledForAuth({
    super.key,
    required this.text,
    required this.keyboardType,
    required this.textDirection,
    this.iconButton,
    this.isHidden,
  });

  final String text;
  final TextInputType keyboardType;
  final TextDirection textDirection;
  final IconButton? iconButton;
  final bool? isHidden;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: textDirection,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      obscureText: isHidden ?? false,
      decoration: InputDecoration(
        hint: Text(
          text,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        suffixIcon: iconButton,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}