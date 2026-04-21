# Changelog

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
