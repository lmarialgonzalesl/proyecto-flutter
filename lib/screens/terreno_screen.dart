import 'package:flutter/material.dart';
import '../models/terreno.dart';

class TerrenoScreen extends StatefulWidget {
  const TerrenoScreen({super.key});

  @override
  State<TerrenoScreen> createState() => _TerrenoScreenState();
}

class _TerrenoScreenState extends State<TerrenoScreen> {
  final _terreno = Terreno();
  bool _caracteristicasExpandido = true;
  bool _serviciosExpandido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terreno')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información del Terreno',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _Acordeon(
              titulo: 'Características',
              icono: Icons.landscape,
              expandido: _caracteristicasExpandido,
              color: Colors.green,
              onToggle: () {
                setState(() {
                  _caracteristicasExpandido = !_caracteristicasExpandido;
                });
              },
              child: Column(
                children: [
                  _CampoTexto(
                    label: 'Accesibilidad',
                    icono: Icons.directions_walk,
                    onChanged: (v) => _terreno.accesibilidad = v,
                  ),
                  const SizedBox(height: 12),
                  _CampoTexto(
                    label: 'Fondo',
                    icono: Icons.straighten,
                    onChanged: (v) => _terreno.fondo = v,
                  ),
                  const SizedBox(height: 12),
                  _CampoTexto(
                    label: 'Pendiente',
                    icono: Icons.trending_up,
                    onChanged: (v) => _terreno.pendiente = v,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _Acordeon(
              titulo: 'Servicios',
              icono: Icons.electrical_services,
              expandido: _serviciosExpandido,
              color: Colors.blue,
              onToggle: () {
                setState(() {
                  _serviciosExpandido = !_serviciosExpandido;
                });
              },
              child: Column(
                children: [
                  _CampoTexto(
                    label: 'Agua',
                    icono: Icons.water_drop,
                    onChanged: (v) => _terreno.agua = v,
                  ),
                  const SizedBox(height: 12),
                  _CampoTexto(
                    label: 'Luz',
                    icono: Icons.lightbulb,
                    onChanged: (v) => _terreno.luz = v,
                  ),
                  const SizedBox(height: 12),
                  _CampoTexto(
                    label: 'Teléfono',
                    icono: Icons.phone,
                    onChanged: (v) => _terreno.telefono = v,
                  ),
                  const SizedBox(height: 12),
                  _CampoTexto(
                    label: 'Internet',
                    icono: Icons.wifi,
                    onChanged: (v) => _terreno.internet = v,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Datos del terreno guardados'),
                    ),
                  );
                },
                child: const Text(
                  'Guardar Terreno',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Acordeon extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final bool expandido;
  final Color color;
  final VoidCallback onToggle;
  final Widget child;

  const _Acordeon({
    required this.titulo,
    required this.icono,
    required this.expandido,
    required this.color,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icono, color: color),
            ),
            title: Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              expandido ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: onToggle,
          ),
          if (expandido)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: child,
            ),
        ],
      ),
    );
  }
}

class _CampoTexto extends StatelessWidget {
  final String label;
  final IconData icono;
  final ValueChanged<String> onChanged;

  const _CampoTexto({
    required this.label,
    required this.icono,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono),
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}
