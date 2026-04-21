import 'package:flutter/material.dart';

import '../widgets/package_list.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
            const Expanded(
              child: PackageList(),
            ),
          ],
        ),
      ),
    );
  }
}
