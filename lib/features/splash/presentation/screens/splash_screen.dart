import 'package:flutter/material.dart';

import '../../../../../core/widgets/nav_bar.dart';
import '../../../packages/data/models/package_model.dart';
import '../../../packages/data/services/package_service.dart';
import '../../../packages/presentation/widgets/package_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Logo sale disparado a la derecha
  late AnimationController _logoExitController;
  late Animation<double> _logoX;
  late Animation<double> _logoExitScaleX;

  // Header (logo + navbar) aparece desde arriba
  late AnimationController _headerFadeController;
  late Animation<double> _headerFade;

  // Contenedor blanco sube desde abajo
  late AnimationController _bodySlideController;
  late Animation<double> _bodySlide;

  List<PackageModel> _packages = [];

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

    _headerFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _headerFade = CurvedAnimation(
      parent: _headerFadeController,
      curve: Curves.easeOut,
    );

    _bodySlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );

    _bodySlide = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _bodySlideController, curve: Curves.easeOut),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    _packages = await PackageService.getMockPackages();

    if (!mounted) return;

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    await _logoExitController.forward();

    if (!mounted) return;

    // Header aparece y cuerpo sube simultáneamente
    _headerFadeController.forward();
    await _bodySlideController.forward();
  }

  @override
  void dispose() {
    _logoExitController.dispose();
    _headerFadeController.dispose();
    _bodySlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          // Layout final: header fijo arriba + body blanco abajo
          Column(
            children: [
              // Header — fades in después de que sale el logo
              AnimatedBuilder(
                animation: _headerFade,
                builder: (_, __) => Opacity(
                  opacity: _headerFade.value,
                  child: Padding(
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
                ),
              ),

              // Contenedor blanco — sube desde abajo
              Expanded(
                child: AnimatedBuilder(
                  animation: _bodySlide,
                  builder: (_, __) => Transform.translate(
                    offset: Offset(0, _bodySlide.value * size.height),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: PackageList(preloadedPackages: _packages),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Logo splash centrado — sale disparado al terminar
          AnimatedBuilder(
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
        ],
      ),
    );
  }
}
