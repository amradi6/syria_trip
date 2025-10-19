import 'package:flutter/material.dart';
import 'package:syri_trip/presentation/auth/screens/singUp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingUp(),
    );
  }
}

