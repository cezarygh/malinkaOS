import 'package:flutter/material.dart';

// The colors used by the navigation (bottom bar and side bar), taken from
// the 21-5 app. There is one set for light mode and one for dark mode.
class NavColors {
  // Behind the side bar on wide screens.
  final Color background;
  // The side bar card and its selected item.
  final Color sideBar;
  final Color sideBarSelected;
  // Text and icons in the side bar.
  final Color text;
  final Color mutedText;
  // The floating bottom bar, its selection circle and its icons.
  final Color pill;
  final Color highlight;
  final Color pillIcon;

  const NavColors({
    required this.background,
    required this.sideBar,
    required this.sideBarSelected,
    required this.text,
    required this.mutedText,
    required this.pill,
    required this.highlight,
    required this.pillIcon,
  });

  // In 0xAARRGGBB colors the first two digits are the opacity:
  // FF is solid, E6 is 90%.
  static const light = NavColors(
    background: Color(0xFFF5F5F5),
    sideBar: Color(0xFFFFFFFF),
    sideBarSelected: Color(0xFFE4E4E5),
    text: Color(0xFF2D2D2D),
    mutedText: Color(0xFFAAAAAA),
    pill: Color(0xE62D2D2D),
    highlight: Color(0xFFC6B299),
    pillIcon: Color(0xFFFFFFFF),
  );

  static const dark = NavColors(
    background: Color(0xFF121212),
    sideBar: Color(0xFF242424),
    sideBarSelected: Color(0xFF363636),
    text: Color(0xFFEDEDED),
    mutedText: Color(0xFF7A7A7A),
    pill: Color(0xE63A3A3A),
    highlight: Color(0xFFC6B299),
    pillIcon: Color(0xFFFFFFFF),
  );

  // Picks the light or dark set based on the current theme.
  static NavColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}
