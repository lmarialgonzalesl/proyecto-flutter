import 'package:flutter/material.dart';
import '../models/bloque.dart';
import '../models/construccion.dart';

class ConstruccionScreen extends StatefulWidget {
  const ConstruccionScreen({super.key});

  @override
  State<ConstruccionScreen> createState() => _ConstruccionScreenState();
}

class _ConstruccionScreenState extends State<ConstruccionScreen> {
  final _construccion = Construccion();

  void _agregarBloque() {
    showDialog(
      context: context,
      builder: (context) => _BloqueDialog(
        onGuardar: (bloque) {
          setState(() {
            _construccion.bloques.add(bloque);
          });
        },
      ),
    );
  }

  void _editarBloque(int index) {
    showDialog(
      context: context,
      builder: (context) => _BloqueDialog(
        bloqueExistente: _construccion.bloques[index],
        onGuardar: (bloque) {
          setState(() {
            _construccion.bloques[index] = bloque;
          });
        },
      ),
    );
  }

  void _eliminarBloque(int index) {
    setState(() {
      _construccion.bloques.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Construcción'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _agregarBloque,
          ),
        ],
      ),
      body: _construccion.bloques.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.build, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay bloques registrados',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Presiona + para agregar un bloque',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _construccion.bloques.length,
              itemBuilder: (context, index) {
                final bloque = _construccion.bloques[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.view_in_ar, color: Colors.orange),
                            const SizedBox(width: 8),
                            Text(
                              'Bloque ${bloque.numeroBloque}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 20),
                              onPressed: () => _editarBloque(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 20,
                                  color: Colors.red),
                              onPressed: () => _eliminarBloque(index),
                            ),
                          ],
                        ),
                        const Divider(),
                        _InfoRow(
                          label: 'Niveles',
                          value: '${bloque.cantidadNiveles}',
                        ),
                        const SizedBox(height: 4),
                        _InfoRow(
                          label: 'Superficie',
                          value: '${bloque.superficie.toStringAsFixed(2)} m²',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: _construccion.bloques.isNotEmpty
          ? FloatingActionButton(
              onPressed: _agregarBloque,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _BloqueDialog extends StatefulWidget {
  final Bloque? bloqueExistente;
  final ValueChanged<Bloque> onGuardar;

  const _BloqueDialog({this.bloqueExistente, required this.onGuardar});

  @override
  State<_BloqueDialog> createState() => _BloqueDialogState();
}

class _BloqueDialogState extends State<_BloqueDialog> {
  final _numeroController = TextEditingController();
  final _nivelesController = TextEditingController();
  final _superficieController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bloqueExistente != null) {
      _numeroController.text = widget.bloqueExistente!.numeroBloque;
      _nivelesController.text =
          widget.bloqueExistente!.cantidadNiveles.toString();
      _superficieController.text =
          widget.bloqueExistente!.superficie.toString();
    }
  }

  @override
  void dispose() {
    _numeroController.dispose();
    _nivelesController.dispose();
    _superficieController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_numeroController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese el número de bloque')),
      );
      return;
    }
    final bloque = Bloque(
      numeroBloque: _numeroController.text,
      cantidadNiveles: int.tryParse(_nivelesController.text) ?? 1,
      superficie: double.tryParse(_superficieController.text) ?? 0,
    );
    widget.onGuardar(bloque);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.bloqueExistente != null;
    return AlertDialog(
      title: Text(esEdicion ? 'Editar Bloque' : 'Nuevo Bloque'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _numeroController,
              decoration: const InputDecoration(
                labelText: 'Número de Bloque',
                prefixIcon: Icon(Icons.tag),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nivelesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad de Niveles',
                prefixIcon: Icon(Icons.layers),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _superficieController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Superficie (m²)',
                prefixIcon: Icon(Icons.square_foot),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _guardar,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
