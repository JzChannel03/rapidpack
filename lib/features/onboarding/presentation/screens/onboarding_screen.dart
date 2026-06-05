import 'package:flutter/material.dart';

import '../../../../../core/services/preferences_service.dart';
import '../../../packages/data/models/package_model.dart';
import '../../../packages/presentation/screens/packages_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final List<PackageModel> preloadedPackages;

  const OnboardingScreen({super.key, required this.preloadedPackages});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  AppMode? _selectedMode;
  Handedness? _selectedHand;

  bool get _canContinue => _selectedMode != null && _selectedHand != null;

  Future<void> _submit() async {
    await PreferencesService.saveOnboarding(
      mode: _selectedMode!,
      handedness: _selectedHand!,
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      _SlideUpRoute(
        page: PackagesScreen(preloadedPackages: widget.preloadedPackages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 16,
              left: 20,
              right: 20,
              bottom: 16,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/rapidpack.jpg',
                    height: 44,
                    width: 44,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          // White body
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 28, 20, bottomPadding + 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Antes de comenzar, cuéntanos\nun poco sobre ti.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Podrás cambiar esto después en tu perfil.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Pregunta 1
                    const _QuestionLabel(
                      number: '1',
                      text: '¿Cómo prefieres ver tus paquetes?',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _OptionCard(
                            icon: Icons.view_agenda_outlined,
                            label: 'Modo simple',
                            description: 'Vista básica,\nfácil de usar',
                            selected: _selectedMode == AppMode.simple,
                            onTap: () =>
                                setState(() => _selectedMode = AppMode.simple),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _OptionCard(
                            icon: Icons.dashboard_outlined,
                            label: 'Modo completo',
                            description: 'Filtros y más\nherramientas',
                            selected: _selectedMode == AppMode.complete,
                            onTap: () => setState(
                                () => _selectedMode = AppMode.complete),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Pregunta 2
                    const _QuestionLabel(
                      number: '2',
                      text: '¿Cómo usas tu teléfono?',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _OptionCard(
                            icon: Icons.back_hand_outlined,
                            label: 'Diestro',
                            description: 'Uso la mano\nderecha',
                            selected: _selectedHand == Handedness.right,
                            onTap: () => setState(
                                () => _selectedHand = Handedness.right),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _OptionCard(
                            icon: Icons.back_hand_outlined,
                            label: 'Zurdo',
                            description: 'Uso la mano\nizquierda',
                            selected: _selectedHand == Handedness.left,
                            onTap: () =>
                                setState(() => _selectedHand = Handedness.left),
                            flipIcon: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Botón continuar
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: _canContinue ? 1.0 : 0.4,
                        child: ElevatedButton(
                          onPressed: _canContinue ? _submit : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.red,
                            disabledForegroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Continuar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionLabel extends StatelessWidget {
  final String number;
  final String text;

  const _QuestionLabel({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  final bool flipIcon;

  const _OptionCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.selected,
    required this.onTap,
    this.flipIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF0EE) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.red : const Color(0xFFE0E0E0),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scaleX: flipIcon ? -1 : 1,
              child: Icon(
                icon,
                color: selected ? Colors.red : const Color(0xFF999999),
                size: 26,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.red : const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF888888),
                height: 1.4,
              ),
            ),
          ],
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
