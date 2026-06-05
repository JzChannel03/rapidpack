# Contexto del Proyecto — RapidPack

## ¿Qué es RapidPack?
App móvil para gestión y seguimiento de paquetes de la empresa courier RapidPack. Orientada al mercado dominicano (precios en RD$). Permite a los usuarios ver sus paquetes en tránsito, estados, pesos, precios, guías y fechas de entrega. RapidPack opera con un almacén en Miami desde donde envían paquetes a República Dominicana.

## Stack
- **Framework:** Flutter 3.38.10 (via FVM)
- **Lenguaje:** Dart 3.10.9
- **Plataformas objetivo:** iOS, Android
- **Estado actual:** Sin backend real — datos hardcodeados (mock)
- **Gestión de versiones Flutter:** FVM
- **Comunicación con backend:** HTTP (GET requests) — no WebSocket

## Arquitectura de datos — estrategia por fases
El app define el contrato de datos (modelos, estructuras de respuesta). El backend se adapta a ese contrato, no al revés.

**Fase 1 — Actual:** Datos mock hardcodeados en el app. Construcción visual completa.

**Fase 2 — BE propio con web scraping:** Se crea un backend que extrae datos del sistema de RapidPack via scraping. Expone endpoints propios con las respuestas ya transformadas al formato que el app espera. El app nunca sabe que los datos vienen de scraping.

**Fase 3 — API oficial de RapidPack:** Cuando se tenga acceso a la API oficial (previo acuerdo/presentación), el BE simplemente cambia la fuente de datos internamente. El app no requiere cambios — ya consume el contrato definido desde la Fase 1.

**Ventaja:** El acceso a la API oficial de RapidPack se negocia presentando una app funcional que ya supera lo que sus apps actuales ofrecen.

## Estructura de carpetas
```
lib/
├── main.dart
├── app/
│   ├── rapidpack_app.dart              # MaterialApp raíz
│   └── _deprecated_app_experiments.dart
├── core/
│   └── widgets/
│       ├── custom_column.dart          # Column con gap automático
│       └── nav_bar.dart                # Barra de navegación flotante
└── features/
    └── packages/
        └── presentation/
            ├── screens/
            │   └── packages_screen.dart
            └── widgets/
                ├── package_list.dart
                └── package_card.dart   # Card definitivo (B + fecha de A)
```

## Paleta de colores
- **Rojo:** `Colors.red` — color de marca principal
- **Blanco:** fondo de cards y cuerpo principal
- **Negro/gris oscuro:** `#1A1A1A` — texto principal
- **Gris claro:** `#F5F5F5`, `#EAEAEA` — fondos de pills y bordes
- **Azul claro:** `#4FC3F7` — acento en fechas expected y etiquetas secundarias
- **Azul oscuro:** `Colors.blue[900]` — chip de estado activo

## Filosofía de diseño
Marca con predominio de blanco y rojo. Sin gradientes ni sombras excesivas. Componentes limpios y minimalistas. El azul claro aparece únicamente como acento puntual (fechas, indicadores). Sin rojo abusivo — se usa como acento, no como fondo dominante en las cards.

- **Diseño del Home/Panel deslizable:** La vista principal de paquetes utiliza un panel deslizable (`DraggableScrollableSheet` con snap). En su estado inicial y mínimo (0.55), deja visible la cabecera y una sección de promociones/noticias (`_AdsSection`) dispuesta en el fondo rojo de la app mediante tarjetas transparentes con estilo glassmorphism. Al deslizarse hacia arriba (hasta 0.95), el panel de paquetes cubre el fondo para optimizar el espacio de lectura.

## Modelo de datos del paquete (a implementar)
Campos conocidos de la API de RapidPack:
- `categoria` — nombre/tipo del paquete (ej. "ACCESORIO DEPORTIVO", "ART PERSONAL Y ACC")
- `guia` — número de guía RapidPack (ej. `WR042301822671`)
- `tracking` — tracking del carrier original (ej. `4203#######61925`)
- `peso` — en libras (ej. `1.85 Lbs`)
- `monto` — precio a pagar en RD$ (ej. `RD$ 420.00`)
- `fecha` — datetime de recepción en almacén Miami (ej. `2024-12-06 09:40:24`)
- `estado` — string del estado actual del paquete
- `fechaExpected` — fecha estimada de entrega (a confirmar si la API lo provee)

## Fecha expected — concepto clave
La fecha expected **no es una fecha simple** del sistema de RapidPack. Es una estimación calculada que considera:
- Historial de tiempos de otros paquetes en el mismo estado
- Condiciones actuales de tránsito (retrasos, clima, aerolíneas)
- Feriados y días no laborables
- Otros factores variables

Se muestra junto a un ícono `ⓘ` que despliega un tooltip explicando esto al usuario. El objetivo es dar claridad real sobre cuándo podrían retirar su paquete, no una fecha arbitraria. **Esta feature depende de los datos accesibles via la API de RapidPack — es una idea a vender que se implementará según lo que esté disponible.**

Debajo de la barra de progreso:
- **Izquierda:** fecha de llegada al terminal/sistema
- **Derecha:** fecha expected + ícono `ⓘ`
- En el expand de detalles: tiempo total en sistema (ej. "12 días, 4 horas en sistema")

## Estados del paquete (flujo conocido)
En orden de progresión (algunos son opcionales según el caso):
1. Recibido en almacén Miami
2. Embarcado (en vuelo)
3. Recibido en aduana / AILA
4. Contenedor para sucursal
5. En camino / En ruta
6. Entregado

Estados especiales (fuera del flujo normal):
- `Retraso línea aérea` — bloquea el avance, aparece con indicador de alerta

## Íconos por tipo de paquete
RapidPack no tiene un campo de tipo de ícono en su sistema. Se debe inferir del nombre de la categoría mediante un modelo local de detección por palabras clave. Fallback: ícono genérico de paquete.

## Perfil de usuario (datos conocidos)
- Código de cliente (ej. `DIHNORA FREEMAN — RP-120402`)
- Dirección física en Miami (ej. `8550 NW 70th ST MIAMI FL 33166-6216`) — copiable

## Assets
- `assets/images/rapidpack.jpg` — logo circular en el header
- `assets/images/package.png` / `package.svg` — ícono genérico de paquete

## Referencia — Apps anteriores de RapidPack
Han tenido dos apps previas, ninguna satisfactoria. Elementos de referencia observados:
- Barra de progreso con íconos por estado (stepper horizontal)
- Botón "Subir Factura" por paquete
- Banner/carousel publicitario en el home
- Pantalla vacía con ilustración "NO TIENES DATOS DISPONIBLES"
- Bottom nav: Inicio, Paquetes, Pre-alerta, Perfil, Más
