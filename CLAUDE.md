# CLAUDE.md — Instrucciones para Claude Code

## Archivos de seguimiento del proyecto

Al terminar cualquier conjunto de cambios en el proyecto, actualizar siempre estos tres archivos:

- **CHANGELOG.md** — Agregar la versión, fecha y los cambios realizados (Added, Changed, Fixed, Removed)
- **CONTEXT.md** — Actualizar si cambia la estructura de carpetas, paleta, stack, o cualquier dato de contexto del proyecto
- **PENDING.md** — Marcar como completado lo que se hizo (`[x]`) y agregar nuevos pendientes que surjan

Esto debe hacerse al final de cada sesión de cambios, antes del commit.

## Widgets reutilizables

Todo widget que pueda usarse en más de un lugar del proyecto va en `lib/core/widgets/`, no dentro de un feature específico. Ejemplos: animaciones, componentes de UI genéricos, wrappers de comportamiento.

Si al escribir un widget dentro de un feature se detecta que es genérico (no depende de datos del feature), extraerlo a `core/widgets/` de inmediato y hacer el import correspondiente.
