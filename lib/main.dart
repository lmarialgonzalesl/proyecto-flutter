import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const SeicuApp());
}

class SeicuApp extends StatelessWidget {
  const SeicuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEICU - Gestión de Trámites',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
