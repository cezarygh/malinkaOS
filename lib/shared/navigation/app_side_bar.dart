import 'package:flutter/material.dart';

import '../theme/nav_colors.dart';
import 'nav_destination.dart';

// Wide-screen navigation: a rounded card with one row (icon + label) per
// page. The selected row gets a grey background.
class AppSideBar extends StatelessWidget {
  final List<NavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AppSideBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const double width = 240;
  static const double radius = 15;

  @override
  Widget build(BuildContext context) {
    final colors = NavColors.of(context);

    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.sideBar,
        borderRadius: BorderRadius.circular(radius),
      ),
      // mainAxisSize.min makes the card only as tall as its rows.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          for (int i = 0; i < destinations.length; i++)
            _SideBarItem(
              destination: destinations[i],
              selected: i == selectedIndex,
              onTap: () => onSelected(i),
            ),
        ],
      ),
    );
  }
}

class _SideBarItem extends StatelessWidget {
  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  const _SideBarItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = NavColors.of(context);
    final foreground = selected ? colors.text : colors.mutedText;
    final borderRadius = BorderRadius.circular(AppSideBar.radius);

    // Material + InkWell give the row a background color and the ripple
    // effect when it is tapped.
    return Material(
      color: selected ? colors.sideBarSelected : Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                selected ? destination.selectedIcon : destination.icon,
                color: foreground,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  destination.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
