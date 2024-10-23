import 'package:flutter/material.dart';
import 'package:rapidpack/widgets/package_list.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Ingrese su nombre',
                      // Etiqueta dentro del campo
                      border: OutlineInputBorder(), // Borde alrededor del campo
                    ),
                    onChanged: (value) {
                      print('Texto ingresado: $value');
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Powered by ParcelsApp")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          const Expanded(child: PackageList())
        ],
      ),
    ));
  }
}
