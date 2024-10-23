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
    return const MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            // Barra personalizada
            MyAppBar(
              title: "RapidPack",
            ),
            // Contenido del cuerpo
            Expanded(
              child: Row(
                children: [MySideBar(), MyHome()],
              ),
            ),
          ],
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
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white54,
      ),
      child: Column(
        children: [Icon(Icons.home_max)],
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
