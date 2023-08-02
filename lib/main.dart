import 'package:calculator/calculator/calculator_cubit.dart';
import 'package:calculator/calculator_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => CalculatorCubit(),
        child: const CalculatorPage(),
      ),
    );
  }
}
