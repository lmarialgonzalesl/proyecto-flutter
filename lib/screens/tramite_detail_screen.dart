import 'package:flutter/material.dart';
import '../models/tramite.dart';
import 'propiedad_screen.dart';
import 'terreno_screen.dart';
import 'construccion_screen.dart';

class TramiteDetailScreen extends StatelessWidget {
  final Tramite tramite;

  const TramiteDetailScreen({super.key, required this.tramite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tramite.id),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tramite.titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            tramite.estado,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Creado: ${tramite.fecha.day}/${tramite.fecha.month}/${tramite.fecha.year}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Secciones del trámite',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _MenuOption(
              icon: Icons.home,
              title: 'Propiedad',
              subtitle: 'Registrar datos catastrales, ubicación y fotos',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PropiedadScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _MenuOption(
              icon: Icons.terrain,
              title: 'Terreno',
              subtitle: 'Características y servicios del terreno',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TerrenoScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _MenuOption(
              icon: Icons.build,
              title: 'Construcción',
              subtitle: 'Registrar bloques, niveles y superficies',
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ConstruccionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
