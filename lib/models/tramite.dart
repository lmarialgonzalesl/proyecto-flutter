class Tramite {
  final String id;
  final String titulo;
  final String estado;
  final DateTime fecha;

  Tramite({
    required this.id,
    required this.titulo,
    this.estado = 'En proceso',
    DateTime? fecha,
  }) : fecha = fecha ?? DateTime.now();
}
