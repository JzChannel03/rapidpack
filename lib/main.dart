import 'package:flutter/material.dart';
import 'package:rapidpack/widgets/app_bar.dart';
import 'package:rapidpack/widgets/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Container(
          color: Colors.red,
          child: Column(
            children: [
              // Barra personalizada
              const MyAppBar(
                title: "RapidPack",
              ),
              // Contenido del cuerpo
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)) 
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      MyHome(),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MySideBar extends StatelessWidget {
  const MySideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 60,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ]),
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home_max),
            color: Colors.white,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.access_time_outlined),
              color: Colors.white),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home_max),
              color: Colors.white),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_2_outlined),
              color: Colors.white),
        ],
      ),
    );
  }
}

// class Sidebar extends StatefulWidget {
//   @override
//   _SidebarState createState() => _SidebarState();
// }
//
// class _SidebarState extends State<Sidebar> {
//   // Índice del botón seleccionado
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[850], // Color del sidebar
//       width: 200, // Ancho del sidebar
//       child: ListView.builder(
//         itemCount: sidebarItems.length,
//         itemBuilder: (context, index) {
//           final item = sidebarItems[index];
//           final isSelected = index == selectedIndex;
//
//           return SidebarButton(
//             icon: item['icon'],
//             label: item['label'],
//             isSelected: isSelected,
//             onTap: () {
//               setState(() {
//                 selectedIndex = index;
//               });
//               print('${item['label']} presionado');
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SidebarButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const SidebarButton({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.blueAccent : Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: isSelected ? Colors.white : Colors.grey[400]),
//             const SizedBox(width: 10),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.grey[400],
//                 fontSize: 16,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
