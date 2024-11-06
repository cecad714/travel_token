import 'package:flutter/material.dart';
import 'package:traveltoken/pages/add_expense_page.dart';
import 'package:traveltoken/pages/add_people_page.dart';
import 'package:traveltoken/pages/home_page.dart';
import 'package:traveltoken/pages/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Token',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
