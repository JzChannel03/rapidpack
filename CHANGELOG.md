# Changelog

## [0.0.8] - 2026-06-04
### Added
- Panel deslizable (`DraggableScrollableSheet`) con efecto snap en `PackagesScreen` para ocultar o revelar contenido del fondo.
- Sección de anuncios y noticias (`_AdsSection`) de la Teoría C en el fondo del stack principal, con un carrusel de tarjetas promocionales en glassmorphism.
- Parámetro `controller` en `PackageList` para vincular el scroll de los paquetes con los gestos del panel deslizable, previniendo bloqueos del scroll en listas vacías o de carga.

### Changed
- Estructura de `PackagesScreen` migrada de `Column` vertical a `Stack` para soportar la superposición del panel deslizable sobre los anuncios.
- Actualización de `PENDING.md` descartando la Teoría A y completando la Teoría C de anuncios.

## [0.0.7] - 2026-04-22
### Added
- Complete mode: full-width search bar below header — filters by category, tracking number, or guide
- Two floating circular FABs (filter + sort) positioned on the dominant hand side (right/left) via `Handedness` preference
- Filter bottom sheet: select one or more package states to narrow the list; "Limpiar" resets selection
- Sort bottom sheet: 7 ordering options (newest/oldest, weight desc/asc, amount desc/asc, by state flow)
- Active badge on FAB buttons when a filter or sort is applied (button turns red); × button below each to clear individually
- `Handedness` now read from `PreferencesService` in `PackagesScreen` alongside `AppMode`

### Changed
- Splash screen: removed hardcoded `const onboardingDone = false` — now reads the real `PreferencesService.isOnboardingDone()` value
- Removed unused `_deprecated_app_experiments.dart`

## [0.0.6] - 2026-04-21
### Added
- Simple mode segmented tabs ("Disponibles" / "Todos") — full-width iOS-style selector above the package list
- "Disponibles" selected by default (left); "Todos" on right — both filter the same list
- `retirado` state to `PackageState` enum — packages in this state are hidden from the main list (reserved for history)

### Changed
- `PackageState` enum refactored: `entregado` → `disponibleParaRetirar` (step 6 of progress bar, full bar = ready to pick up); `retirado` added as step 7
- Progress bar redesigned: continuous `LinearProgressIndicator` with animated fill + circular nodes rendered on top; replaced segmented line approach
- `TweenAnimationBuilder` now uses `key: ValueKey(activeIndex)` — fixes state reuse bug that caused right-to-left fill animation when switching tabs
- `PackagesScreen` converted to `StatefulWidget` — loads `AppMode` from `PreferencesService` and applies tab filtering
- Mock JSON updated: PKG-006 → `disponibleParaRetirar`, PKG-008 added with `retirado` state

### Fixed
- Progress bar fill animating right-to-left for packages at position [0] after tab switch (Flutter widget state reuse)

---

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
