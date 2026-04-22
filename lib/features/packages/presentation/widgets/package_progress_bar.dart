import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/pulsing_widget.dart';
import '../../data/models/package_model.dart';

const _stepIcons = [
  Icons.warehouse_outlined,
  Icons.flight,
  Icons.account_balance_outlined,
  Icons.move_to_inbox_outlined,
  Icons.local_shipping_outlined,
  Icons.back_hand_outlined,
];

const _kNodeSize = 30.0;
const _kBarHeight = 10.0;

class PackageProgressBar extends StatelessWidget {
  final PackageState currentState;
  final bool hasDelay;
  final DateTime arrivalDate;
  final DateTime expectedDate;

  PackageProgressBar({
    super.key,
    this.currentState = PackageState.embarcado,
    this.hasDelay = false,
    DateTime? arrivalDate,
    DateTime? expectedDate,
  })  : arrivalDate = arrivalDate ?? DateTime(2023, 7, 24),
        expectedDate = expectedDate ?? DateTime(2026, 4, 28);

  int get _activeIndex =>
      currentState.index.clamp(0, _stepIcons.length - 1);

  @override
  Widget build(BuildContext context) {
    final activeIndex = _activeIndex;
    final totalSteps = _stepIcons.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Builder(
          builder: (context) {
            final halfNode = _kNodeSize / 2;
            final targetProgress =
                activeIndex == 0 ? 0.0 : activeIndex / (totalSteps - 1);

            return SizedBox(
              height: _kNodeSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Barra animada con LinearProgressIndicator
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: halfNode),
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey(activeIndex),
                      tween: Tween(begin: 0.0, end: targetProgress),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOut,
                      builder: (_, value, __) => LinearProgressIndicator(
                        value: value,
                        backgroundColor: const Color(0xFFE8E8E8),
                        valueColor:
                            const AlwaysStoppedAnimation(Colors.red),
                        minHeight: _kBarHeight,
                        borderRadius:
                            BorderRadius.circular(_kBarHeight / 2),
                      ),
                    ),
                  ),

                  // Nodos encima
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < totalSteps; i++)
                        _StepNode(
                          icon: _stepIcons[i],
                          state: i < activeIndex
                              ? _NodeState.completed
                              : i == activeIndex
                                  ? (hasDelay
                                      ? _NodeState.delayed
                                      : _NodeState.active)
                                  : _NodeState.pending,
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        if (hasDelay)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 13, color: Colors.amber[700]),
                const SizedBox(width: 4),
                Text(
                  'Retraso línea aérea',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.amber[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatDate(arrivalDate),
              style: const TextStyle(
                  fontSize: 11, color: Color(0xFF999999)),
            ),
            Row(
              children: [
                Text(
                  formatDate(expectedDate),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF4FC3F7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                PulsingWidget(
                  maxScale: 1.35,
                  minOpacity: 0.6,
                  child: GestureDetector(
                    onTap: () => _showExpectedInfo(context),
                    child: const Icon(
                      Icons.info_outline,
                      size: 13,
                      color: Color(0xFF4FC3F7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _showExpectedInfo(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black12,
      builder: (_) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: Color(0xFF4FC3F7)),
                  SizedBox(width: 8),
                  Text(
                    'Fecha estimada',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Calculada según el historial de paquetes similares, '
                'condiciones actuales y posibles retrasos. '
                'Puede variar.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _NodeState { completed, active, delayed, pending }

class _StepNode extends StatelessWidget {
  final IconData icon;
  final _NodeState state;

  const _StepNode({required this.icon, required this.state});

  @override
  Widget build(BuildContext context) {
    final isActive =
        state == _NodeState.active || state == _NodeState.delayed;

    final Color bg = switch (state) {
      _NodeState.completed => Colors.red,
      _NodeState.active    => Colors.red,
      _NodeState.delayed   => Colors.amber,
      _NodeState.pending   => const Color(0xFFE8E8E8),
    };

    final Color iconColor = switch (state) {
      _NodeState.pending => const Color(0xFFBBBBBB),
      _                  => Colors.white,
    };

    final node = Container(
      width: _kNodeSize,
      height: _kNodeSize,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: bg.withOpacity(isActive ? 0.45 : 0.15),
            blurRadius: isActive ? 6 : 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 13, color: iconColor),
    );

    if (!isActive) return node;

    return PulsingWidget(
      minScale: 1.0,
      maxScale: 1.12,
      minOpacity: 0.85,
      maxOpacity: 1.0,
      duration: const Duration(milliseconds: 1100),
      child: node,
    );
  }
}
