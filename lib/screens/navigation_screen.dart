import 'package:flutter/material.dart';
import 'tramites_list_screen.dart';
import 'propiedad_screen.dart';
import 'terreno_screen.dart';
import 'construccion_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TramitesListScreen(embedded: true),
    PropiedadScreen(embedded: true),
    TerrenoScreen(embedded: true),
    ConstruccionScreen(embedded: true),
  ];

  final List<String> _titles = const [
    'Trámites',
    'Propiedad',
    'Terreno',
    'Construcción',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: _currentIndex == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Trámites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Propiedad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.terrain),
            label: 'Terreno',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Construcción',
          ),
        ],
      ),
    );
  }
}
