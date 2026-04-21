import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/pulsing_widget.dart';
import '../../data/models/package_model.dart';

const _steps = [
  _Step(icon: Icons.warehouse_outlined),
  _Step(icon: Icons.flight),
  _Step(icon: Icons.account_balance_outlined),
  _Step(icon: Icons.move_to_inbox_outlined),
  _Step(icon: Icons.local_shipping_outlined),
  _Step(icon: Icons.check_circle_outline),
];

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

  @override
  Widget build(BuildContext context) {
    final activeIndex = currentState.index;

    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < _steps.length; i++) ...[
              _StepNode(
                icon: _steps[i].icon,
                state: i < activeIndex
                    ? _NodeState.completed
                    : i == activeIndex
                        ? (hasDelay ? _NodeState.delayed : _NodeState.active)
                        : _NodeState.pending,
              ),
              if (i < _steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    color: i < activeIndex ? Colors.red : const Color(0xFFE0E0E0),
                  ),
                ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        if (hasDelay)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, size: 13, color: Colors.amber[700]),
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
              style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Color(0xFF4FC3F7)),
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
    final Color bgColor = switch (state) {
      _NodeState.completed => Colors.red,
      _NodeState.active    => Colors.red,
      _NodeState.delayed   => Colors.amber,
      _NodeState.pending   => const Color(0xFFEAEAEA),
    };

    final Color iconColor = switch (state) {
      _NodeState.pending => const Color(0xFFBBBBBB),
      _                  => Colors.white,
    };

    final isActive = state == _NodeState.active || state == _NodeState.delayed;
    final double size = isActive ? 32 : 28;

    final node = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: isActive
            ? [BoxShadow(color: bgColor.withOpacity(0.4), blurRadius: 6, spreadRadius: 1)]
            : null,
      ),
      child: Icon(icon, size: 14, color: iconColor),
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

class _Step {
  final IconData icon;
  const _Step({required this.icon});
}
