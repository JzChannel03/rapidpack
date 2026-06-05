import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const NavBar({
    super.key,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.darkRed,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(0, Icons.home_outlined, Icons.home),
          _buildItem(1, Icons.access_time_outlined, Icons.access_time),
          _buildItem(2, Icons.notifications_outlined, Icons.notifications),
          _buildItem(3, Icons.person_outline, Icons.person),
        ],
      ),
    );
  }

  Widget _buildItem(int index, IconData outlineIcon, IconData filledIcon) {
    final isSelected = selectedIndex == index;
    return IconButton(
      onPressed: () => onTap?.call(index),
      icon: Icon(isSelected ? filledIcon : outlineIcon),
      color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
    );
  }
}
