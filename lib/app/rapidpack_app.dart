import 'package:flutter/material.dart';

import '../features/splash/presentation/screens/splash_screen.dart';

class RapidPackApp extends StatelessWidget {
  const RapidPackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RapidPack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
