import 'package:flutter/material.dart';

// Describes one page in the navigation: its label, icons and the screen
// to show. Both the bottom bar (mobile) and the side rail (desktop) are
// built from the same list of these.
class NavDestination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget screen;

  const NavDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.screen,
  });
}
