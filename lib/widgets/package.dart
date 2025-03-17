import 'package:flutter/material.dart';

class PackageContainer extends StatelessWidget {
  const PackageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: const Column(
          children: [
            PackageDetails(),
          ],
        ));
  }
}

class PackageDetails extends StatelessWidget {
  const PackageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '#4589632579',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              Chip(
                label: const Text('Procesando'),
                backgroundColor: Colors.blue[900],
                labelStyle: const TextStyle(color: Colors.white),
                elevation: 4,
                padding: const EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              )
            ],
          ),
          const Divider(color: Colors.white, thickness: 1),
        ],
      ),
    );
  }
}

// class PackageDetails extends StatelessWidget {
//   const PackageDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Center(
//           child: Text(
//             'ACCESORIO DEPORTIVO',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           decoration: const BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.all(Radius.circular(10))),
//           height: 12,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(10),
//                               topLeft: Radius.circular(10))),
//                       child: const Center(
//                         child: Text(
//                           '1.85 Lb',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(10),
//                               topRight: Radius.circular(10))),
//                       child: const Center(
//                         child: Text(
//                           'RD\$ 420.00',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
