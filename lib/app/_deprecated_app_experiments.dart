// =============================================================================
// DEPRECATED — Experimentos de estructura inicial
// =============================================================================
// Este archivo guarda los dos enfoques originales de la app, antes de migrar
// a la estructura modular. Están comentados para que puedas revisar cuál era
// cuál y qué estabas probando en cada uno.
//
// Para reactivar cualquiera de los dos:
//   1. Descomenta el bloque que te interesa
//   2. En main.dart cambia `runApp(const RapidPackApp())` por el widget que
//      corresponda (ver nota en cada bloque)
// =============================================================================

// ignore_for_file: unused_import, dead_code

import 'package:flutter/material.dart';

// =============================================================================
// EXPERIMENTO A — MyAppBar como raíz (el que estaba corriendo)
// =============================================================================
// Enfoque: MyAppBar actuaba como MaterialApp + Scaffold + header rojo + lista.
// Todo en un solo widget. Para activar: runApp(const MyAppBarExperiment())
//
// class MyAppBarExperiment extends StatelessWidget {
//   const MyAppBarExperiment({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               // Barra personalizada
//               Container(
//                 color: Colors.red,
//                 padding: const EdgeInsets.all(16.0),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'RapidPack',
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                     Icon(Icons.settings, color: Colors.white),
//                   ],
//                 ),
//               ),
//               // Contenido del cuerpo
//               // const Expanded(child: Packages()),
//             ],
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

