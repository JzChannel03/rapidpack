import 'package:flutter/material.dart';

import '../../../../../core/services/preferences_service.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../data/models/package_model.dart';
import '../widgets/package_list.dart';

class PackagesScreen extends StatefulWidget {
  final List<PackageModel>? preloadedPackages;

  const PackagesScreen({super.key, this.preloadedPackages});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  AppMode? _mode;
  bool _showAvailableOnly = true;

  // Excluye retirados del listado principal (van a historial)
  static bool _isVisible(PackageModel p) =>
      p.estado != PackageState.retirado;

  static bool _isAvailable(PackageModel p) =>
      p.estado == PackageState.disponibleParaRetirar;

  List<PackageModel>? get _displayPackages {
    final all = widget.preloadedPackages;
    if (all == null) return null;
    final visible = all.where(_isVisible).toList();
    return _showAvailableOnly ? visible.where(_isAvailable).toList() : visible;
  }

  @override
  void initState() {
    super.initState();
    PreferencesService.getAppMode().then((m) {
      if (mounted) setState(() => _mode = m);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final isSimple = _mode == AppMode.simple;

    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Column(
          children: [
            Padding(
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
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    if (isSimple)
                      _SimpleModeTabs(
                        showAvailableOnly: _showAvailableOnly,
                        onChanged: (val) =>
                            setState(() => _showAvailableOnly = val),
                      ),
                    Expanded(
                      child: PackageList(preloadedPackages: _displayPackages),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleModeTabs extends StatelessWidget {
  final bool showAvailableOnly;
  final ValueChanged<bool> onChanged;

  const _SimpleModeTabs({
    required this.showAvailableOnly,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Disponibles — izquierda, seleccionado por defecto
            Expanded(
              child: _Tab(
                label: 'Disponibles',
                selected: showAvailableOnly,
                onTap: () => onChanged(true),
                isLeft: true,
              ),
            ),
            // Todos — derecha
            Expanded(
              child: _Tab(
                label: 'Todos',
                selected: !showAvailableOnly,
                onTap: () => onChanged(false),
                isLeft: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isLeft;

  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.red : const Color(0xFF999999),
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
