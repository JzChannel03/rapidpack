# Pending — RapidPack

## Completado
- [x] Elegir diseño definitivo de `PackageCard` — combinación de A y B
- [x] Barra de progreso del paquete con estados, nodo activo animado e ícono `ⓘ`
- [x] Fechas en español con formato uniforme usando `intl`
- [x] Modelo de datos `PackageModel` + JSON mock + `PackageService`
- [x] `PulsingWidget` genérico en `core/widgets/`

---

## Próximo a implementar

### Splash screen
- [ ] Pantalla de splash al entrar al app:
  - Fondo rojo completo (sin cuerpo blanco)
  - Logo de RapidPack centrado a mayor tamaño
  - Animación del logo: movimiento rápido hacia la derecha (efecto velocidad)
  - Timer de 3 segundos simulando carga
  - Al terminar: logo sale por la derecha y el contenedor blanco con los paquetes sube desde abajo

### Onboarding de accesibilidad (primera vez — via shared_preferences)
- [ ] Al entrar por primera vez, mostrar pantalla de preferencias antes del home:
  - **Pregunta 1:** ¿Modo simple o completo?
  - **Pregunta 2:** ¿Eres zurdo o diestro? (para posicionar elementos del lado de la mano dominante)
- [ ] Guardar preferencias en `shared_preferences` y no volver a mostrar en siguientes aperturas

### Modo simple
- [ ] Dos botones de texto encima del listado, en línea horizontal: **"Todos"** y **"Listos para retirar"**
- [ ] Diseño pendiente de sketch del usuario — orientado a personas con poca experiencia en apps
- [ ] Sin filtros complejos ni elementos adicionales

### Modo completo
- [ ] Botones flotantes del lado de la mano dominante del usuario para filtrar y ordenar:
  - Por fecha, estado, y otros criterios a definir
  - Cada botón con una `x` debajo para limpiar ese filtro individualmente
- [ ] Diseño pendiente de sketch del usuario

### NavBar — estado offline
- [ ] Cuando no hay conexión, el NavBar se muestra completamente blanco con texto "Sin conexión"
- [ ] Botón de refresh a la derecha que gira al presionarlo para reintentar la carga

### Pull to refresh
- [ ] Arrastrar hacia abajo la lista de paquetes activa un loading y recarga los datos

---

## Features por implementar

### Paquetes entregados — estilo diferenciado
- [ ] Los paquetes con estado `entregado` se muestran con estilo visual distinto (ej. card en gris, opacidad reducida, ícono de check, barra de progreso colapsada o en tono gris)

### Filtros de paquetes
- [ ] Criterios a definir — ideas iniciales: por estado, por fecha, activos vs entregados
- [ ] Definir si van como tabs, chips horizontales o dropdown

### Expand / detalle de paquete
- [ ] Al tocar una card, mostrar detalles expandidos — evaluar entre:
  - **Opción A:** panel que se arrastra desde la derecha (slide-in)
  - **Opción B:** expand inline debajo de la card
- [ ] Datos en el detalle:
  - Guía RapidPack (ej. `WR042301822671`)
  - Tracking del carrier (ej. `4203#######61925`) + botón para rastrear externamente
  - Tiempo en sistema (ej. "12 días, 4 horas en sistema")
  - Foto del paquete *(baja prioridad — depende de RapidPack)*
- [ ] Botón "Subir Factura" en el detalle

### Ícono por tipo de paquete
- [ ] Modelo local de detección por palabras clave en el nombre de categoría → ícono
- [ ] Fallback: ícono genérico de paquete

### Datos reales
- [ ] Integración con API HTTP (GET de paquetes al entrar al app)
- [ ] Estados de carga (skeleton/spinner) y error
- [ ] Estado vacío: pantalla "No tienes datos disponibles" con ilustración

### Offline cache (local storage)
- [ ] GET exitoso → guardar localmente
- [ ] Sin conexión → mostrar último cache (nunca vacío)
- [ ] Indicador visual: "Última actualización: fecha/hora"

### Navegación
- [ ] Conectar los 4 botones del NavBar a sus pantallas
- [ ] Pantallas: Home (paquetes), Historial, Notificaciones, Perfil

### Perfil de usuario
- [ ] Código de cliente y dirección Miami con botón Copiar

### Internacionalización
- [ ] Soporte multilenguaje (español/inglés) — actualmente todo en español por defecto

### Infraestructura
- [ ] Configurar git con nombre y email (`git config --global`)
- [ ] Variables de entorno para base URL de API

### Backend (fase futura)
- [ ] BE propio con web scraping del sistema de RapidPack
- [ ] Contrato de endpoints definido desde el app (modelo primero)
- [ ] Al tener API oficial: reemplazar scraping internamente sin cambiar el app
