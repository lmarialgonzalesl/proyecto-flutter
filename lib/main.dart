import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const AppPredios());
}

class AppPredios extends StatelessWidget {
  const AppPredios({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relevamiento de Predios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
