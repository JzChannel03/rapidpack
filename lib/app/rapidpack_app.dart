import 'package:flutter/material.dart';

import '../features/packages/presentation/screens/packages_screen.dart';

class RapidPackApp extends StatelessWidget {
  const RapidPackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RapidPack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PackagesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
