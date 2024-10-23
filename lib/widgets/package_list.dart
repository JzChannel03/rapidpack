import 'package:flutter/material.dart';

import 'package.dart';
import 'ui/custom_column.dart';

class PackageList extends StatelessWidget {
  const PackageList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: CustomColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        gap: 16,
        children: [
          PackageContainer(),
          PackageContainer(),
          PackageContainer(),
          PackageContainer(),
          PackageContainer(),
          PackageContainer(),
          PackageContainer(),
        ],
      ),
    );
  }
}
