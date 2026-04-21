import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_column.dart';
import '../../data/models/package_model.dart';
import '../../data/services/package_service.dart';
import 'package_card.dart';

class PackageList extends StatelessWidget {
  const PackageList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PackageModel>>(
      future: PackageService.getMockPackages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No hay paquetes disponibles.',
              style: TextStyle(color: Color(0xFF999999)),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              gap: 12,
              children: snapshot.data!
                  .map((p) => PackageCard(package: p))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
