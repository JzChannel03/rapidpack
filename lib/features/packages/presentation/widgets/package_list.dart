import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_column.dart';
import 'package_card.dart';

class PackageList extends StatelessWidget {
  const PackageList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          gap: 16,
          children: [
            PackageCard(),
            PackageCard(),
            PackageCard(),
            PackageCard(),
            PackageCard(),
            PackageCard(),
            PackageCard(),
          ],
        ),
      ),
    );
  }
}
