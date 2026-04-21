# Pending — RapidPack

## Completado
- [x] Elegir diseño definitivo de `PackageCard` — combinación de A y B

---

## Próximo a implementar

### 1. Expand / detalle de paquete
- [ ] Al tocar una card, mostrar detalles expandidos — evaluar entre:
  - **Opción A:** panel que se arrastra desde la derecha (slide-in)
  - **Opción B:** expand inline debajo de la card
- [ ] Datos a mostrar en el detalle:
  - Guía RapidPack (ej. `WR042301822671`)
  - Tracking del carrier (ej. `4203#######61925`) + botón para rastrear externamente
  - Foto del paquete *(pending con baja prioridad — depende de que RapidPack lo integre en su plataforma)*
- [ ] Botón "Subir Factura" visible en el detalle

### 2. Barra de progreso del paquete
- [ ] Implementar barra de progreso con íconos por estado (estilo stepper horizontal)
- [ ] Estados conocidos del flujo (en orden, algunos opcionales según el caso):
  1. Recibido en almacén Miami
  2. Embarcado (en vuelo)
  3. Recibido en aduana / AILA
  4. Contenedor para sucursal
  5. En camino / En ruta
  6. Entregado
- [ ] Estados especiales que aparecen en casos específicos:
  - `Retraso línea aérea` — bloquea el avance, se muestra con indicador de alerta
  - Otros estados a confirmar con la API real
- [ ] El estado activo resalta visualmente; los anteriores aparecen completados y los siguientes en gris
- [ ] Debajo de la barra de progreso, mostrar dos fechas:
  - **Izquierda:** fecha de llegada al sistema/terminal (ej. `24/07/2023`)
  - **Derecha:** fecha expected de entrega con ícono informativo `ⓘ`
- [ ] El ícono `ⓘ` junto a la fecha expected despliega un tooltip explicando que la fecha es calculada considerando: historial de paquetes en el mismo estado, condiciones actuales de tránsito, feriados, posibles retrasos y otros factores — no es una fecha exacta sino una estimación inteligente
- [ ] Días y horas en el sistema desde que llegó al almacén — mostrar en el expand de detalles (ej. "12 días, 4 horas en sistema")
- [ ] **Nota:** La fecha expected calculada es una idea a vender — su viabilidad depende de los datos accesibles via API de RapidPack. Se implementará lo posible con lo disponible

### 3. Ícono por tipo de paquete
- [ ] Crear modelo local de detección de tipo basado en el nombre/categoría del paquete
  - El sistema de RapidPack no tiene un campo de tipo de ícono — se infiere del texto
  - Ejemplos: "ACCESORIO DEPORTIVO" → ícono deportivo, "ARTICULO PERSONAL Y ACCESORIOS" → ícono personal, "ELECTRÓNICO" → ícono electrónico, etc.
- [ ] Definir un mapa de palabras clave → ícono (Flutter `Icons` o assets SVG)
- [ ] Fallback: ícono genérico de paquete si ninguna palabra clave hace match

---

## Features por implementar

### Datos reales
- [ ] Definir modelo de datos `Package` completo:
  - `categoria` (nombre del paquete)
  - `guia` (número de guía RapidPack, ej. WR...)
  - `tracking` (tracking del carrier antes de llegar a RapidPack)
  - `peso` (libras)
  - `monto` (RD$)
  - `fecha` (datetime de recepción)
  - `estado` (string del estado actual)
  - `fechaExpected` (fecha estimada de entrega)
- [ ] Integración con API HTTP (GET de paquetes al entrar al app)
- [ ] Manejo de estados de carga (skeleton/spinner) y error en la lista
- [ ] Estado vacío: pantalla "No tienes datos disponibles" con ilustración

### Offline cache (local storage)
- [ ] Al realizar un GET exitoso, guardar la respuesta localmente
- [ ] Al entrar sin conexión, mostrar los últimos datos cacheados
- [ ] El storage solo se borra y reemplaza cuando llegan datos nuevos con éxito (nunca queda vacío)
- [ ] Evaluar: `shared_preferences` para datos simples o `hive` para estructuras más complejas
- [ ] Indicador visual de datos offline (ej. "Última actualización: 21 abr, 2:34 PM")

### Navegación
- [ ] Conectar los 4 botones del `NavBar` a sus pantallas
- [ ] Definir pantallas: Home (paquetes), Historial, Notificaciones, Perfil
- [ ] Bottom nav bar definitivo (referencia: apps de RapidPack tenían: Inicio, Paquetes, Pre-alerta, Perfil, Más)

### Perfil de usuario
- [ ] Mostrar código de cliente (ej. `DIHNORA FREEMAN — RP-120402`)
- [ ] Mostrar dirección física en Miami (ej. `8550 NW 70th ST MIAMI FL 33166-6216`) con botón Copiar

### Infraestructura
- [ ] Configurar git con nombre y email (`git config --global`)
- [ ] Definir entorno de desarrollo (variables de entorno para base URL de API)

### Backend (fase futura)
- [ ] Crear BE propio con web scraping del sistema de RapidPack
- [ ] Definir y documentar el contrato de endpoints que el app consumirá (basado en los modelos del app)
- [ ] Transformar respuestas del scraping al formato esperado por el app
- [ ] Cuando se tenga acceso a API oficial de RapidPack: reemplazar scraping internamente sin tocar el app
