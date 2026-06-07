# APP Movil - Relevamiento de Información de Predios In Situ

Aplicación móvil desarrollada en Flutter como propuesta para que los **Gobiernos Autonomos Municpales (GAMS)** puedan realizar el relevamiento de información de un predio de forma directa **in situ**, digitalizando el proceso de captura de datos catastrales, características del terreno, servicios disponibles y registro de construcciones.

## Funcionalidades

- **Login** — Acceso seguro a la aplicación
- **Trámites** — Listado de trámites en proceso con acceso a detalle
- **Propiedad** — Registro de código catastral, geocódigo, ubicación en mapa interactivo (OpenStreetMap) y fotografías de frente y fondo
- **Terreno** — Captura de características del terreno (accesibilidad, fondo, pendiente) y servicios (agua, luz, teléfono, internet) mediante acordeones
- **Construcción** — Registro de bloques de construcción con número de bloque, cantidad de niveles y superficie

## Tecnologías

- **Flutter** — Framework multiplataforma
- **flutter_map + latlong2** — Mapas interactivos OpenStreetMap sin necesidad de API key
- **image_picker** — Captura de fotografías desde la cámara del dispositivo

## Estructura del proyecto

```
lib/
├── main.dart
├── models/
│   ├── tramite.dart
│   ├── propiedad.dart
│   ├── terreno.dart
│   ├── construccion.dart
│   └── bloque.dart
└── screens/
    ├── login_screen.dart
    ├── tramites_list_screen.dart
    ├── tramite_detail_screen.dart
    ├── propiedad_screen.dart
    ├── terreno_screen.dart
    └── construccion_screen.dart
```

## Cómo ejecutar

```bash
flutter pub get
flutter run
```
