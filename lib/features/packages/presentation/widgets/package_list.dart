import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_column.dart';
import '../../data/models/package_model.dart';
import '../../data/services/package_service.dart';
import 'package_card.dart';

class PackageList extends StatelessWidget {
  final List<PackageModel>? preloadedPackages;
  final ScrollController? controller;

  const PackageList({
    super.key,
    this.preloadedPackages,
    this.controller,
  });

  Widget _buildList(List<PackageModel> packages) {
    return SingleChildScrollView(
      controller: controller,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: CustomColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          gap: 12,
          children: packages.map((p) => PackageCard(package: p)).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (preloadedPackages != null) {
      return preloadedPackages!.isEmpty
          ? SingleChildScrollView(
              controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              child: const SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    'No hay paquetes disponibles.',
                    style: TextStyle(color: Color(0xFF999999)),
                  ),
                ),
              ),
            )
          : _buildList(preloadedPackages!);
    }

    return FutureBuilder<List<PackageModel>>(
      future: PackageService.getMockPackages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            child: const SizedBox(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SingleChildScrollView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            child: const SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  'No hay paquetes disponibles.',
                  style: TextStyle(color: Color(0xFF999999)),
                ),
              ),
            ),
          );
        }

        return _buildList(snapshot.data!);
      },
    );
  }
}
