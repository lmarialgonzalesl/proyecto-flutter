import 'package:flutter/material.dart';
import '../models/tramite.dart';
import 'tramite_detail_screen.dart';

class TramitesListScreen extends StatelessWidget {
  const TramitesListScreen({super.key});

  List<Tramite> _tramites() {
    return [
      Tramite(
        id: 'TR-001',
        titulo: 'Regularización de propiedad - Av. Central',
        fecha: DateTime(2026, 5, 20),
      ),
      Tramite(
        id: 'TR-002',
        titulo: 'Certificación de terreno - Colonia del Valle',
        fecha: DateTime(2026, 5, 28),
      ),
      Tramite(
        id: 'TR-003',
        titulo: 'Licencia de construcción - Blvd. Reforma',
        fecha: DateTime(2026, 6, 1),
      ),
      Tramite(
        id: 'TR-004',
        titulo: 'División de predio - Las Lomas',
        fecha: DateTime(2026, 5, 15),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tramites = _tramites();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Trámites'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: tramites.isEmpty
          ? const Center(
              child: Text(
                'No hay trámites en proceso',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tramites.length,
              itemBuilder: (context, index) {
                final tramite = tramites[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(
                      Icons.description,
                      color: Colors.blue,
                      size: 36,
                    ),
                    title: Text(
                      tramite.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${tramite.id} - ${_formatDate(tramite.fecha)}',
                    ),
                    trailing: Chip(
                      label: Text(
                        tramite.estado,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TramiteDetailScreen(tramite: tramite),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
