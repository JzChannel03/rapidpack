import 'package:flutter/material.dart';

import '../../../../../core/services/preferences_service.dart';
import '../../../packages/data/models/package_model.dart';
import '../../../packages/data/services/package_service.dart';
import '../../../packages/presentation/screens/packages_screen.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoExitController;
  late Animation<double> _logoX;
  late Animation<double> _logoExitScaleX;

  @override
  void initState() {
    super.initState();

    _logoExitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _logoX = Tween<double>(begin: 0.0, end: 1.8).animate(
      CurvedAnimation(parent: _logoExitController, curve: Curves.easeIn),
    );

    _logoExitScaleX = Tween<double>(begin: 1.0, end: 1.6).animate(
      CurvedAnimation(parent: _logoExitController, curve: Curves.easeIn),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    final packages = await PackageService.getMockPackages();
    // DEBUG: force onboarding every launch for testing
    const onboardingDone = false;
    await PreferencesService.isOnboardingDone(); // keep call to avoid unused import

    if (!mounted) return;

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    await _logoExitController.forward();

    if (!mounted) return;

    final next = onboardingDone
        ? PackagesScreen(preloadedPackages: packages)
        : OnboardingScreen(preloadedPackages: packages);

    Navigator.pushReplacement(
      context,
      _SlideUpRoute(page: next),
    );
  }

  @override
  void dispose() {
    _logoExitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red,
      body: AnimatedBuilder(
        animation: _logoExitController,
        builder: (_, __) => Opacity(
          opacity: (1.0 - _logoExitController.value).clamp(0.0, 1.0),
          child: Center(
            child: Transform.translate(
              offset: Offset(_logoX.value * size.width, 0),
              child: Transform.scale(
                scaleX: _logoExitScaleX.value,
                scaleY: 1.0,
                child: Image.asset(
                  'assets/images/logo-dark.png',
                  width: 220,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SlideUpRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  _SlideUpRoute({required this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
}
