import 'package:flutter/material.dart';

class PulsingWidget extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final double minOpacity;
  final double maxOpacity;
  final Duration duration;

  const PulsingWidget({
    super.key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 1.25,
    this.minOpacity = 0.6,
    this.maxOpacity = 1.0,
    this.duration = const Duration(milliseconds: 900),
  });

  @override
  State<PulsingWidget> createState() => _PulsingWidgetState();
}

class _PulsingWidgetState extends State<PulsingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _scale = Tween<double>(begin: widget.minScale, end: widget.maxScale)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacity = Tween<double>(begin: widget.minOpacity, end: widget.maxOpacity)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.scale(
        scale: _scale.value,
        child: Opacity(opacity: _opacity.value, child: widget.child),
      ),
    );
  }
}
