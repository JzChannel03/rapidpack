import 'package:flutter/material.dart';
import 'package:rapidpack/main.dart';

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
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/images/rapidpack.jpg',
            ),
          ),
          // Text(
          //   title,
          //   style: const TextStyle(color: Colors.white, fontSize: 30),
          // ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.all(5),
          //     backgroundColor: Colors.transparent,
          //     shadowColor: Colors.transparent,
          //     elevation: 0,
          //   ),
          //   onPressed: () {
          //   },
          //   child: const Row(
          //     children: [
          //       Icon(Icons.supervised_user_circle_outlined, color: Colors.white),
          //       SizedBox(width: 5),
          //       Text('Mi Perfil', style: TextStyle(color: Colors.white)),
          //     ],
          //   ),
          // )

          const MySideBar(),
        ],
      ),
    );
  }
}
