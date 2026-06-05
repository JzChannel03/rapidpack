import 'package:flutter/material.dart';

import '../../../../../core/services/preferences_service.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/nav_bar.dart';
import '../../../../../core/widgets/pulsing_widget.dart';
import '../../data/models/package_model.dart';
import '../widgets/package_list.dart';

enum _SortOption {
  newest,
  oldest,
  byWeightDesc,
  byWeightAsc,
  byAmountDesc,
  byAmountAsc,
  byState,
}

class PackagesScreen extends StatefulWidget {
  final List<PackageModel>? preloadedPackages;

  const PackagesScreen({super.key, this.preloadedPackages});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  AppMode? _mode;
  Handedness _handedness = Handedness.right;
  bool _showAvailableOnly = true;

  final _searchController = TextEditingController();
  String _searchQuery = '';
  Set<PackageState> _filterStates = {};
  _SortOption _sortOption = _SortOption.newest;
  final _sheetController = DraggableScrollableController();

  bool get _hasActiveFilter => _filterStates.isNotEmpty;
  bool get _hasActiveSort => _sortOption != _SortOption.newest;

  static bool _isVisible(PackageModel p) => p.estado != PackageState.retirado;
  static bool _isAvailable(PackageModel p) =>
      p.estado == PackageState.disponibleParaRetirar;

  List<PackageModel>? get _displayPackages {
    final all = widget.preloadedPackages;
    if (all == null) return null;
    final visible = all.where(_isVisible).toList();

    if (_mode == AppMode.simple) {
      return _showAvailableOnly
          ? visible.where(_isAvailable).toList()
          : visible;
    }

    var result = visible;

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result = result
          .where((p) =>
              p.categoria.toLowerCase().contains(q) ||
              p.guia.toLowerCase().contains(q) ||
              p.tracking.toLowerCase().contains(q))
          .toList();
    }

    if (_filterStates.isNotEmpty) {
      result = result.where((p) => _filterStates.contains(p.estado)).toList();
    }

    result = List.of(result);
    switch (_sortOption) {
      case _SortOption.newest:
        result.sort((a, b) => b.fechaLlegada.compareTo(a.fechaLlegada));
      case _SortOption.oldest:
        result.sort((a, b) => a.fechaLlegada.compareTo(b.fechaLlegada));
      case _SortOption.byWeightDesc:
        result.sort((a, b) => b.peso.compareTo(a.peso));
      case _SortOption.byWeightAsc:
        result.sort((a, b) => a.peso.compareTo(b.peso));
      case _SortOption.byAmountDesc:
        result.sort((a, b) => b.monto.compareTo(a.monto));
      case _SortOption.byAmountAsc:
        result.sort((a, b) => a.monto.compareTo(b.monto));
      case _SortOption.byState:
        result.sort((a, b) => a.estado.index.compareTo(b.estado.index));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();
    PreferencesService.getAppMode().then((m) {
      if (mounted) setState(() => _mode = m);
    });
    PreferencesService.getHandedness().then((h) {
      if (mounted) setState(() => _handedness = h);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _FilterSheet(
        activeStates: _filterStates,
        onApply: (states) => setState(() => _filterStates = states),
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _SortSheet(
        current: _sortOption,
        onSelect: (opt) => setState(() => _sortOption = opt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final isSimple = _mode == AppMode.simple;
    final isComplete = _mode == AppMode.complete;
    final isRight = _handedness == Handedness.right;

    // Cálculo dinámico para la separación del navbar de forma equitativa en cualquier pantalla.
    final screenHeight = MediaQuery.of(context).size.height;
    // Altura de cabecera: padding superior + paddings Row (12+12) + logo/NavBar (50) + separación visual (24)
    final headerHeight = topPadding + 12 + 50 + 12 + 16;
    final maxChildSize = ((screenHeight - headerHeight) / screenHeight).clamp(0.60, 0.95);
    final minAndInitialSize = 0.55.clamp(0.20, maxChildSize);

    return Scaffold(
      body: Container(
        color: AppColors.primaryRed,
        child: Stack(
          children: [
            // Contenido de fondo: Cabecera y sección de anuncios
            Column(
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
                const _AdsSection(),
              ],
            ),

            // Panel deslizable con el listado de paquetes
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: minAndInitialSize,
              minChildSize: minAndInitialSize,
              maxChildSize: maxChildSize,
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Indicación animada de deslizamiento (reemplaza la manija estática)
                      Center(
                        child: AnimatedBuilder(
                          animation: _sheetController,
                          builder: (context, _) {
                            final size = _sheetController.isAttached
                                ? _sheetController.size
                                : minAndInitialSize;
                            // Se desvanece de 1.0 a 0.0 a medida que sube
                            final fadeEnd = minAndInitialSize + 0.15;
                            final opacity = ((fadeEnd - size) / (fadeEnd - minAndInitialSize)).clamp(0.0, 1.0);
                            return Opacity(
                              opacity: opacity,
                              child: Visibility(
                                visible: opacity > 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12, bottom: 4),
                                  child: PulsingWidget(
                                    minScale: 0.96,
                                    maxScale: 1.04,
                                    duration: const Duration(milliseconds: 1000),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.keyboard_double_arrow_up,
                                          color: Colors.red.withValues(alpha: 0.7),
                                          size: 18,
                                        ),
                                        if (isSimple) ...[
                                          const SizedBox(height: 2),
                                          Text(
                                            'Desliza para ver todos los paquetes',
                                            style: TextStyle(
                                              color: AppColors.textDark.withValues(alpha: 0.6),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (isSimple)
                        _SimpleModeTabs(
                          showAvailableOnly: _showAvailableOnly,
                          onChanged: (val) =>
                              setState(() => _showAvailableOnly = val),
                        ),
                      if (isComplete)
                        _SearchBar(
                          controller: _searchController,
                          onChanged: (q) => setState(() => _searchQuery = q),
                        ),
                      Expanded(
                        child: PackageList(
                          preloadedPackages: _displayPackages,
                          controller: scrollController,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Botones flotantes (FABs) para modo completo colocados estáticamente encima del Stack
            if (isComplete)
              _CompleteModeFABs(
                isRight: isRight,
                hasActiveFilter: _hasActiveFilter,
                hasActiveSort: _hasActiveSort,
                onFilter: _showFilterSheet,
                onSort: _showSortSheet,
                onClearFilter: () => setState(() => _filterStates = {}),
                onClearSort: () => setState(
                    () => _sortOption = _SortOption.newest),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Search bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: const TextStyle(fontSize: 14, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: 'Buscar por categoría, guía o tracking...',
          hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          prefixIcon:
              const Icon(Icons.search, color: AppColors.textMuted, size: 20),
          suffixIcon: hasText
              ? GestureDetector(
                  onTap: () {
                    widget.controller.clear();
                    widget.onChanged('');
                  },
                  child: const Icon(Icons.close,
                      color: AppColors.textMuted, size: 18),
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          filled: true,
          fillColor: AppColors.surfaceGray,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.borderGray, width: 1),
          ),
        ),
      ),
    );
  }
}

// ─── Floating action buttons ───────────────────────────────────────────────────

class _CompleteModeFABs extends StatelessWidget {
  final bool isRight;
  final bool hasActiveFilter;
  final bool hasActiveSort;
  final VoidCallback onFilter;
  final VoidCallback onSort;
  final VoidCallback onClearFilter;
  final VoidCallback onClearSort;

  const _CompleteModeFABs({
    required this.isRight,
    required this.hasActiveFilter,
    required this.hasActiveSort,
    required this.onFilter,
    required this.onSort,
    required this.onClearFilter,
    required this.onClearSort,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: isRight ? 16 : null,
      left: isRight ? null : 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FABButton(
            icon: Icons.filter_list,
            isActive: hasActiveFilter,
            onTap: onFilter,
            onClear: hasActiveFilter ? onClearFilter : null,
          ),
          const SizedBox(height: 12),
          _FABButton(
            icon: Icons.sort,
            isActive: hasActiveSort,
            onTap: onSort,
            onClear: hasActiveSort ? onClearSort : null,
          ),
        ],
      ),
    );
  }
}

class _FABButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _FABButton({
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryRed : AppColors.background,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textDark,
              size: 22,
            ),
          ),
        ),
        if (onClear != null) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onClear,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.surfaceGray,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close,
                  size: 13, color: AppColors.textGray),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Filter bottom sheet ───────────────────────────────────────────────────────

class _FilterSheet extends StatefulWidget {
  final Set<PackageState> activeStates;
  final ValueChanged<Set<PackageState>> onApply;

  const _FilterSheet({required this.activeStates, required this.onApply});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late Set<PackageState> _selected;

  static const _labels = {
    PackageState.almacenMiami: 'Almacén Miami',
    PackageState.embarcado: 'Embarcado',
    PackageState.aduanaAila: 'Aduana / AILA',
    PackageState.contenedorSucursal: 'Contenedor para sucursal',
    PackageState.enCamino: 'En camino',
    PackageState.disponibleParaRetirar: 'Disponible para retirar',
  };

  @override
  void initState() {
    super.initState();
    _selected = Set.of(widget.activeStates);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtrar por estado',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _selected.clear()),
                child: const Text('Limpiar',
                    style: TextStyle(color: AppColors.primaryRed)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ..._labels.entries.map((e) => _CheckRow(
                label: e.value,
                checked: _selected.contains(e.key),
                onToggle: () => setState(() {
                  if (_selected.contains(e.key)) {
                    _selected.remove(e.key);
                  } else {
                    _selected.add(e.key);
                  }
                }),
              )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(Set.of(_selected));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
                foregroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
              child: const Text('Aplicar',
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  final String label;
  final bool checked;
  final VoidCallback onToggle;

  const _CheckRow({
    required this.label,
    required this.checked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: checked ? AppColors.primaryRed : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked ? AppColors.primaryRed : AppColors.borderGray,
                  width: 1.5,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(label,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }
}

// ─── Sort bottom sheet ─────────────────────────────────────────────────────────

class _SortSheet extends StatelessWidget {
  final _SortOption current;
  final ValueChanged<_SortOption> onSelect;

  const _SortSheet({required this.current, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const options = [
      (_SortOption.newest, 'Más reciente primero'),
      (_SortOption.oldest, 'Más antiguo primero'),
      (_SortOption.byWeightDesc, 'Mayor peso primero'),
      (_SortOption.byWeightAsc, 'Menor peso primero'),
      (_SortOption.byAmountDesc, 'Mayor monto primero'),
      (_SortOption.byAmountAsc, 'Menor monto primero'),
      (_SortOption.byState, 'Por estado (flujo)'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ordenar por',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          ...options.map((entry) {
            final (opt, label) = entry;
            final isSelected = current == opt;
            return GestureDetector(
              onTap: () {
                onSelect(opt);
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected
                              ? AppColors.primaryRed
                              : AppColors.textDark,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: AppColors.primaryRed, size: 18),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Simple mode tabs ──────────────────────────────────────────────────────────

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
          color: AppColors.surfaceGray,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: _Tab(
                label: 'Disponibles',
                selected: showAvailableOnly,
                onTap: () => onChanged(true),
                isLeft: true,
              ),
            ),
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
          color: selected ? AppColors.background : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
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
              color: selected ? AppColors.primaryRed : AppColors.textMuted,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Ads Section ──────────────────────────────────────────────────────────────

class _AdItem {
  final IconData icon;
  final String title;
  final String description;

  const _AdItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _AdsSection extends StatelessWidget {
  const _AdsSection();

  static const List<_AdItem> _ads = [
    _AdItem(
      icon: Icons.local_offer,
      title: 'Tarifa Especial RD\$',
      description: '¡Solo RD\$150 por libra en vuelos de Miami esta semana!',
    ),
    _AdItem(
      icon: Icons.local_shipping,
      title: 'Delivery Gratis',
      description: 'Envío a domicilio sin costo para paquetes de más de 5 Lbs.',
    ),
    _AdItem(
      icon: Icons.receipt,
      title: 'Sube tu Factura',
      description: 'Evita retrasos en aduanas subiendo tu factura a tiempo.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.campaign, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Noticias y Promociones',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _ads.length,
              itemBuilder: (context, index) {
                final ad = _ads[index];
                return Container(
                  width: 280,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          ad.icon,
                          color: AppColors.accentBlue,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ad.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ad.description,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 12,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
