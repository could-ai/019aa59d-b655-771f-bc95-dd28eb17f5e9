import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PdfToLatexApp());
}

class PdfToLatexApp extends StatelessWidget {
  const PdfToLatexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF to LaTeX Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomeScreen(),
    );
  }
}
