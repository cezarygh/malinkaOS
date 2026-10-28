import 'package:flutter/material.dart';

import '../theme/nav_colors.dart';
import 'nav_destination.dart';

// Mobile navigation: a dark, rounded "pill" floating above the bottom of
// the screen. A sand-colored circle sits behind the selected icon and
// slides to the new icon when you tap another page.
class AppBottomBar extends StatelessWidget {
  final List<NavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AppBottomBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const double height = 70;
  // How much width each page gets in the pill.
  static const double widthPerItem = 80;

  // Where an item sits inside the pill. Alignment x goes from -1 (left edge)
  // to 1 (right edge), so the items are spread evenly between the two.
  Alignment _alignmentFor(int index) {
    if (destinations.length == 1) return Alignment.center;
    return Alignment(-1 + 2 * index / (destinations.length - 1), 0);
  }

  @override
  Widget build(BuildContext context) {
    final colors = NavColors.of(context);

    // SafeArea keeps the bar above the iPhone home indicator. Where there is
    // none, "minimum" still gives it 16 px of space.
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 17),
        // heightFactor: 1 makes Center only as tall as the pill, instead of
        // taking up the whole screen height.
        child: Center(
          heightFactor: 1,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: destinations.length * widthPerItem,
            ),
            child: Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                color: colors.pill,
                borderRadius: BorderRadius.circular(height / 2),
              ),
              // Stack draws its children on top of each other: first the
              // circle, then the icons above it.
              child: Stack(
                children: [
                  // AnimatedAlign animates by itself whenever its alignment
                  // changes, which makes the circle slide.
                  AnimatedAlign(
                    alignment: _alignmentFor(selectedIndex),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    child: Container(
                      width: height,
                      height: height,
                      decoration: BoxDecoration(
                        color: colors.highlight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  for (int i = 0; i < destinations.length; i++)
                    Align(
                      alignment: _alignmentFor(i),
                      child: _BottomBarItem(
                        destination: destinations[i],
                        selected: i == selectedIndex,
                        color: colors.pillIcon,
                        onTap: () => onSelected(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final NavDestination destination;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.destination,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // The bar shows no text, so Semantics gives screen readers the label.
    return Semantics(
      label: destination.label,
      button: true,
      selected: selected,
      child: SizedBox(
        width: AppBottomBar.height,
        height: AppBottomBar.height,
        child: InkResponse(
          onTap: onTap,
          radius: 28,
          child: Icon(
            selected ? destination.selectedIcon : destination.icon,
            color: color,
            size: 20,
          ),
        ),
      ),
    );
  }
}
