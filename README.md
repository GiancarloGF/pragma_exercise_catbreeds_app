# Catbreeds App

Aplicación Flutter informativa para explorar razas de gatos consumiendo datos desde [The Cat API](https://api.thecatapi.com/v1/breeds).

La app permite:

- Consultar un listado de razas.
- Buscar razas por nombre en inglés.
- Abrir el detalle de cada raza.
- Visualizar información relevante como país de origen, peso, expectativa de vida, temperamento y características numéricas.

## Descripción funcional

La aplicación está compuesta por dos pantallas principales:

1. `Landing`
   - Muestra un bloque informativo superior con el buscador.
   - Presenta el listado de razas en formato vertical.
   - Cada card muestra imagen, nombre, país de origen y nivel de inteligencia.
   - Solo el listado de resultados es scrolleable.

2. `Detalle`
   - Muestra una imagen destacada de la raza.
   - Presenta un resumen rápido con métricas clave.
   - Incluye descripción, temperamento y una lista vertical de características.

## Tecnologías y dependencias

El proyecto usa:

- `Flutter`
- `Dart`
- `http` para consumo de API
- `google_fonts` para tipografía
- `flutter_native_splash` para splash screen nativo
- `flutter_launcher_icons` para generar launcher icons

## Estructura del proyecto

```text
lib/
  app/
    app.dart
  config/
    app_config.dart
  models/
    cat_breed.dart
  screens/
    landing_screen.dart
    breed_detail_screen.dart
  services/
    cat_api_service.dart
  theme/
    app_theme.dart
  widgets/
    breed_list_item.dart
    brutalist_card.dart
    info_pill.dart
  main.dart

```

## Arquitectura general

La solución es deliberadamente simple:

- `CatApiService` se encarga de consultar `The Cat API`.
- `CatBreed` representa el modelo principal de dominio.
- `LandingScreen` maneja búsqueda local sobre la lista ya cargada.
- `BreedDetailScreen` presenta la información detallada.
- `theme/` y `widgets/` concentran la capa visual reutilizable.

No se usa state management externo. El estado se maneja con `StatefulWidget`, `setState` y `FutureBuilder`.

## Fuente de datos

La app consume:

- `GET https://api.thecatapi.com/v1/breeds`

La llave de acceso está centralizada en:

- `lib/config/app_config.dart`

Actualmente la app usa una constante interna para el `api_key`.

## Requisitos para ejecutar el proyecto

Se recomienda contar con:

- Flutter `3.38.x` o compatible con `Dart 3.10.x`
- Dart SDK compatible con el `pubspec.yaml`
- Android Studio, VS Code o cualquier entorno con soporte Flutter
- Un emulador/dispositivo Android, iOS, Web o Desktop

## Cómo correr la aplicación

1. Instalar dependencias:

```bash
flutter pub get
```

2. Ejecutar la aplicación:

```bash
flutter run
```

Si deseas correrla en una plataforma específica, por ejemplo Chrome:

```bash
flutter run -d chrome
```

O listar dispositivos disponibles:

```bash
flutter devices
```

## Validación del proyecto

Para revisar análisis estático:

```bash
flutter analyze
```

Para ejecutar pruebas:

```bash
flutter test
```

## Splash screen nativo

El proyecto ya incluye configuración de splash nativo con:

- `flutter_native_splash`
- archivo: `flutter_native_splash.yaml`

Si necesitas regenerarlo:

```bash
dart run flutter_native_splash:create
```

## Launcher icon

El proyecto ya incluye configuración de icono de aplicación con:

- `flutter_launcher_icons`
- archivo: `flutter_launcher_icons.yaml`
- asset usado: `assets/images/main_icon.png`

Si necesitas regenerarlo:

```bash
dart run flutter_launcher_icons
```

## Nombre visible de la app

El nombre mostrado al usuario es:

- `Catbreeds`

Este nombre fue configurado en Android, iOS, Web y en la app Flutter.

## Observaciones

- El icono de iOS puede requerir `remove_alpha_ios: true` si se quiere dejar preparado específicamente para App Store.
- La llave de API está dentro del proyecto por simplicidad del ejercicio.
- La app está pensada como una implementación práctica de prueba técnica, priorizando claridad y mantenibilidad.
