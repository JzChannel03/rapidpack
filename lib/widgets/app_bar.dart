import 'package:flutter/material.dart';
import 'package:rapidpack/widgets/packages.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            // Barra personalizada
            Container(
              color: Colors.red,
              padding: const EdgeInsets.all(16.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RapidPack',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Icon(Icons.settings, color: Colors.white),
                ],
              ),
            ),
            // Contenido del cuerpo
            const Expanded(
              child: Packages(),
            ),
          ],
        ),
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}
