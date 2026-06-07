import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/propiedad.dart';

class PropiedadScreen extends StatefulWidget {
  final bool embedded;

  const PropiedadScreen({super.key, this.embedded = false});

  @override
  State<PropiedadScreen> createState() => _PropiedadScreenState();
}

class _PropiedadScreenState extends State<PropiedadScreen> {
  final _propiedad = Propiedad();
  final _codigoController = TextEditingController();
  final _geocodigoController = TextEditingController();
  final _picker = ImagePicker();

  static const _centroInicial = LatLng(19.4326, -99.1332);

  @override
  void dispose() {
    _codigoController.dispose();
    _geocodigoController.dispose();
    super.dispose();
  }

  Future<void> _tomarFoto(bool esFrente) async {
    final xfile = await _picker.pickImage(source: ImageSource.camera);
    if (xfile != null) {
      setState(() {
        if (esFrente) {
          _propiedad.fotoFrente = xfile.path;
        } else {
          _propiedad.fotoFondo = xfile.path;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos de la Propiedad',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(
                labelText: 'Código Catastral',
                prefixIcon: Icon(Icons.tag),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _propiedad.codigoCatastral = v,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _geocodigoController,
              decoration: const InputDecoration(
                labelText: 'Geocódigo',
                prefixIcon: Icon(Icons.pin_drop),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _propiedad.geocodigo = v,
            ),
            const SizedBox(height: 24),
            const Text(
              'Ubicación en el mapa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: _centroInicial,
                    initialZoom: 15,
                    onTap: (tapPosition, point) {
                      setState(() {
                        _propiedad.latitud = point.latitude;
                        _propiedad.longitud = point.longitude;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.seicu.app',
                    ),
                    if (_propiedad.latitud != null &&
                        _propiedad.longitud != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(
                              _propiedad.latitud!,
                              _propiedad.longitud!,
                            ),
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (_propiedad.latitud != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Lat: ${_propiedad.latitud!.toStringAsFixed(6)}, '
                  'Lng: ${_propiedad.longitud!.toStringAsFixed(6)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            const SizedBox(height: 24),
            const Text(
              'Fotografías',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _FotoWidget(
                    label: 'Frente',
                    imagePath: _propiedad.fotoFrente,
                    onTap: () => _tomarFoto(true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _FotoWidget(
                    label: 'Fondo',
                    imagePath: _propiedad.fotoFondo,
                    onTap: () => _tomarFoto(false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Datos de propiedad guardados'),
                    ),
                  );
                },
                child: const Text(
                  'Guardar Propiedad',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );

    if (widget.embedded) return body;
    return Scaffold(appBar: AppBar(title: const Text('Propiedad')), body: body);
  }
}

class _FotoWidget extends StatelessWidget {
  final String label;
  final String? imagePath;
  final VoidCallback onTap;

  const _FotoWidget({
    required this.label,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/placeholder.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.grey,
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        TextButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.camera, size: 16),
          label: Text(imagePath != null ? 'Cambiar' : 'Tomar foto'),
        ),
      ],
    );
  }
}
