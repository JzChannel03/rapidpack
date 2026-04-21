import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;
  final TextDirection? textDirection;

  const CustomColumn({
    super.key,
    required this.children,
    this.gap = 0.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      textDirection: textDirection,
      children: _addGapToChildren(children, gap),
    );
  }

  List<Widget> _addGapToChildren(List<Widget> children, double gap) {
    if (children.isEmpty) return [];
    return [
      for (int i = 0; i < children.length; i++) ...[
        children[i],
        if (i != children.length - 1) SizedBox(height: gap),
      ]
    ];
  }
}
