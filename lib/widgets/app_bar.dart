import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {

  final String title;

  const MyAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(16.0),
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(5),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
            onPressed: () {
              print('Botón Mi Perfil presionado');
            },
            child: const Row(
              children: [
                Icon(Icons.supervised_user_circle_outlined, color: Colors.white),
                SizedBox(width: 5),
                Text('Mi Perfil', style: TextStyle(color: Colors.white)),
              ],
            ),
          )

        ],
      ),
    );
  }
}
