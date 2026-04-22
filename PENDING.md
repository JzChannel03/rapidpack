# Pending — RapidPack

## Completado
- [x] Elegir diseño definitivo de `PackageCard` — combinación de A y B
- [x] Barra de progreso del paquete con estados, nodo activo animado e ícono `ⓘ`
- [x] Fechas en español con formato uniforme usando `intl`
- [x] Modelo de datos `PackageModel` + JSON mock + `PackageService`
- [x] `PulsingWidget` genérico en `core/widgets/`
- [x] Splash screen — fondo rojo, logo centrado, carga en background, logo sale disparado, header fade in + body slide up
- [x] Onboarding de accesibilidad — primera vez: modo simple/completo + diestro/zurdo, guardado en `shared_preferences`

---

## Próximo a implementar

### Onboarding — modo por defecto según edad (pendiente de conversación)
- [ ] Evaluar si preguntar la edad en el onboarding o inferirla
- [ ] Usuarios mayores de 50 años podrían tener **modo simple seleccionado por defecto** como sugerencia, dejando libertad de cambiarlo
- [ ] Analizar cómo hacerlo sin resultar condescendiente en el UX

### Onboarding — usar preferencias guardadas
- [x] Leer `AppMode` y `Handedness` desde `PreferencesService` en `PackagesScreen`
- [x] Aplicar modo simple o completo según preferencia
- [x] Posicionar botones flotantes según mano dominante (modo completo)

### ~~Modo simple~~ ✅ Completado
- [x] Dos tabs encima del listado: **"Disponibles"** y **"Todos"** — filtran la misma lista
- [x] "Disponibles" = solo `disponibleParaRetirar`; barra completa indica listo para retiro
- [x] "Disponibles" seleccionado por defecto (izquierda); full-width, estilo iOS segmented control
- [x] Paquetes `retirado` ocultos del listado principal (van a historial, próxima feature)

### ~~Modo completo~~ ✅ Completado (Task-Rap-6)
- [x] Barra de búsqueda full-width debajo del header — filtra por categoría, guía o tracking
- [x] Dos botones flotantes circulares (filtro + orden) posicionados según `Handedness`
- [x] Filter bottom sheet: por estado (6 estados), con "Limpiar" y "Aplicar"
- [x] Sort bottom sheet: 7 opciones (más reciente, más antiguo, peso, monto, estado)
- [x] Badge activo en FAB (rojo) + botón × para limpiar individualmente
- [x] Sin tabs en modo completo
- [x] `isOnboardingDone` real activado en splash (removido `const onboardingDone = false`)

#### Pendiente de modo completo
- [ ] Filtro por rango de fecha de llegada (requiere date picker — postergado)
- [ ] Filtro por rango de peso o monto (pendiente de conversación con cliente)

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

### Píldora de precio — indicador de cálculo
- [ ] Mostrar ícono junto al precio que indique que el monto es resultado de precio por libra × peso
- [ ] Definir diseño (ícono de calculadora, multiplicación, o tooltip)

### Anuncios informativos — pendiente de análisis
- [ ] Teorías a evaluar, definir cuál usar o combinar:
  - **Teoría A — banner entre header y listado:** sección discreta y no molesta justo debajo del header, siempre visible pero sin interrumpir el flujo
  - **Teoría B — durante la carga:** aprovechar el splash o el tiempo de carga para mostrar anuncios antes de que aparezcan los paquetes
  - **Teoría C — panel deslizable:** el listado baja y queda visible un área de anuncios debajo (estilo drawer o scroll reveal)
  - **Teoría D — pantalla de anuncio prioritario:** si hay un anuncio importante, ocupa el espacio de los paquetes al entrar; al aceptar o cerrar, los paquetes aparecen
- [ ] Definir tipos de anuncio: informativos generales vs. alertas importantes
- [ ] Definir origen de los anuncios: hardcodeados, JSON mock, o futura API
- [ ] Analizar UX: cuándo mostrar, frecuencia, si se puede volver a ver
- [ ] El cliente siempre incluye anuncios en sus apps — confirmar formato y contenido típico con él

### Costos adicionales (pendiente de conversación con cliente)
- [ ] Algunos paquetes pueden tener costos adicionales: seguro, impuestos, otros
- [ ] Ninguna app actual de RapidPack soporta esto — requiere conversación con el cliente para definir cómo mostrarlo
- [ ] Ideas iniciales: badge o indicador en la card, sección separada en el detalle del paquete

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
