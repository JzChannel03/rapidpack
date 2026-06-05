# GEMINI.md — Instrucciones de Desarrollo para Gemini (Antigravity)

Este archivo define las directrices y comandos clave para que Gemini (Antigravity) trabaje de manera eficiente en el proyecto **RapidPack**, respetando la arquitectura y las decisiones previas.

## Comandos del Proyecto (FVM / Flutter)

Todas las tareas de Flutter se ejecutan a través de **FVM** para garantizar la consistencia de la versión del SDK:

- **Obtener dependencias:** `fvm flutter pub get`
- **Limpiar el proyecto:** `fvm flutter clean`
- **Ejecutar análisis estático:** `fvm flutter analyze`
- **Ejecutar pruebas unitarias:** `fvm flutter test`
- **Ejecutar la app (desarrollo):** `fvm flutter run`

## Estructura de Control y Seguimiento

Al finalizar cualquier sesión de desarrollo o conjunto de cambios, es obligatorio actualizar:

1. **`CHANGELOG.md`**: Registrar la versión actual, fecha y los cambios detallados en secciones `Added`, `Changed`, `Fixed`, `Removed`.
2. **`CONTEXT.md`**: Actualizar la estructura del proyecto, paletas, stack técnico o lógica del negocio si sufren modificaciones.
3. **`PENDING.md`**: Marcar como completado lo realizado (`[x]`) y registrar nuevos pendientes o tareas que surjan.

## Guías de Arquitectura y Estilo

- **Widgets Reutilizables:** Todo componente UI genérico o comportamiento reutilizable (animaciones, campos genéricos, columnas especiales) debe ir en `lib/core/widgets/`. Los widgets específicos de una funcionalidad van dentro de su respectivo `features/[nombre_feature]/presentation/widgets/`.
- **Preferencia de Diseño:** Seguir fielmente la paleta de colores oficial y la filosofía minimalista (blanco predominante, acentos en rojo de marca y detalles de información en azul claro, sin abuso de sombras ni gradientes).
- **Internacionalización:** El idioma predeterminado del app y formateo es el español (`es`), utilizando la librería `intl`.

## Flujo de Trabajo en Gemini (Antigravity)

- Para cambios complejos o nuevas características, crearemos primero un plan de implementación (`implementation_plan.md`) y lo validaremos con el usuario antes de proceder a la ejecución.
- Mantendremos siempre la integridad de la documentación existente y comentarios de código.

## Errores Comunes y Soluciones

### Error de compilación en iOS / Simulador (`iOS XX.X is not installed`)
Si al intentar ejecutar en el simulador de iOS obtienes un error como:
`Unable to find a destination matching the provided destination specifier` o `iOS XX.X is not installed. Please download and install the platform from Xcode > Settings > Components.`

**Solución:**
1. Asegúrate de que las plataformas soportadas estén configuradas correctamente en `Runner.xcodeproj` (`SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";`).
2. Descarga la plataforma/runtime de iOS faltante para la versión actual de Xcode ejecutando:
   ```bash
   xcodebuild -downloadPlatform iOS
   ```

