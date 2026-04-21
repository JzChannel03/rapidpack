# Changelog

## [0.0.5] - 2026-04-21
### Added
- Onboarding screen — first-time flow with two questions: app mode (simple/complete) and handedness (right/left)
- `PreferencesService` — reads/writes `shared_preferences` for mode, handedness, onboarding status
- `shared_preferences ^2.3.2` added as dependency

### Changed
- `SplashScreen` refactored to navigate (pushReplacement with slide-up transition) instead of rendering screens inline
- Splash checks onboarding status and routes to `OnboardingScreen` or `PackagesScreen` accordingly
- `PackageCard` pills row now spans full card width, icon row vertically centered

---

## [0.0.4] - 2026-04-21
### Added
- `SplashScreen` — fondo rojo completo con logo centrado, 3s de espera con carga en background
- Logo sale disparado a la derecha (stretch + easeIn) al terminar la carga
- Header (logo circular + NavBar) hace fade in después de que sale el logo
- Contenedor blanco con paquetes sube desde abajo independientemente del header
- `assets/images/logo-dark.png` — logo oficial RapidPack con fondo transparente

### Changed
- `PackagesScreen` acepta `preloadedPackages` opcional para evitar doble carga
- `PackageList` usa `preloadedPackages` directamente si están disponibles, omitiendo el `FutureBuilder`
- `RapidPackApp` apunta a `SplashScreen` como home

---

## [0.0.3] - 2026-04-21
### Added
- `PackageModel` con todos los campos del paquete + enum `PackageState`
- `PackageService` — carga y parsea `assets/mock/packages.json` via rootBundle
- JSON mock con 7 paquetes en distintos estados para desarrollo
- `PackageProgressBar` — stepper horizontal con 6 estados, nodo activo animado, retraso en ámbar
- `PulsingWidget` genérico en `core/widgets/` — animación de pulso reutilizable
- `date_formatter.dart` en `core/utils/` — fechas en español con `intl`
- Ícono `ⓘ` animado con dialog compacto explicando la fecha estimada
- Fondo rojo extendido hasta la barra de notificaciones (sin SafeArea, con padding manual)
- `intl` como dependencia para formateo de fechas

### Changed
- `PackageCard` ahora recibe `PackageModel` — datos reales del JSON
- `PackageList` usa `FutureBuilder` con `PackageService`
- `PackageProgressBar` importa `PackageState` desde el modelo (sin duplicación)

---

## [0.0.2] - 2026-04-21
### Added
- Estructura modular por features (`app/`, `core/`, `features/`)
- `RapidPackApp` como entry point correcto con MaterialApp y tema
- `NavBar` flotante con 4 íconos en `core/widgets/`
- `PackageCard` definitivo — combinación de CardA y CardB: layout horizontal (ícono + nombre + Fecha Expected) con pills LB/precio y fecha expected con ícono de calendario abajo
- FVM configurado con Flutter 3.38.10
- Archivos de seguimiento: `CHANGELOG.md`, `CONTEXT.md`, `PENDING.md`, `CLAUDE.md`

### Changed
- Layout de `PackagesScreen`: fondo rojo + cuerpo blanco con bordes redondeados
- Header actualizado: logo circular + NavBar
- `CustomColumn` movido a `core/widgets/`

### Merged
- Rama `redesign`: logo, layout rojo/blanco, NavBar, assets del logo

### Fixed
- Entry point incorrecto (`runApp(MyAppBar())` → `runApp(RapidPackApp())`)
- Estructura de carpetas sin módulos

---

## [0.0.1] - 2024 (Initial commit)
### Added
- UI base: header rojo, lista de paquetes hardcodeada
- `CustomColumn` con gap automático entre hijos
- Widgets iniciales: `MyAppBar`, `Packages`, `Package`, `PackageDetails`
