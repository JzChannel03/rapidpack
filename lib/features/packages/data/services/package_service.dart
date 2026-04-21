import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/package_model.dart';

class PackageService {
  static Future<List<PackageModel>> getMockPackages() async {
    final raw = await rootBundle.loadString('assets/mock/packages.json');
    final List<dynamic> data = json.decode(raw);
    return data.map((e) => PackageModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}
