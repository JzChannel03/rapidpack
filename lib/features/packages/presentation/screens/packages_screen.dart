import 'package:flutter/material.dart';

import '../../../../../core/widgets/nav_bar.dart';
import '../widgets/package_list.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: topPadding + 12,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/rapidpack.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const NavBar(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: const PackageList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
