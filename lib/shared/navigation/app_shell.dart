import 'package:flutter/material.dart';

import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/projects/presentation/projects_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../layout/breakpoints.dart';
import 'nav_destination.dart';

// The pages in the app, in the order they appear in the navigation.
// To add a page, add a new NavDestination here.
const List<NavDestination> destinations = [
  NavDestination(
    label: 'Dashboard',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    screen: DashboardScreen(),
  ),
  NavDestination(
    label: 'Projects',
    icon: Icons.folder_outlined,
    selectedIcon: Icons.folder,
    screen: ProjectsScreen(),
  ),
  NavDestination(
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
    screen: SettingsScreen(),
  ),
];

// The "frame" around every page. It holds the navigation and decides
// whether to show a bottom bar (mobile) or a side rail (desktop).
//
// It is a StatefulWidget because it must remember which page is selected.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    // setState tells Flutter the data changed, so build() runs again.
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // IndexedStack keeps all pages alive but only shows one. This means a
    // page keeps its scroll position and loaded data when you switch away.
    final Widget pages = IndexedStack(
      index: _selectedIndex,
      children: [for (final destination in destinations) destination.screen],
    );

    final double screenWidth = MediaQuery.sizeOf(context).width;

    if (screenWidth < mobileBreakpoint) {
      return _buildMobileLayout(pages);
    } else {
      return _buildDesktopLayout(pages);
    }
  }

  // Mobile: the page fills the screen with a navigation bar at the bottom.
  Widget _buildMobileLayout(Widget pages) {
    return Scaffold(
      body: pages,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          for (final destination in destinations)
            NavigationDestination(
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.label,
            ),
        ],
      ),
    );
  }

  // Desktop: a navigation rail on the left, the page on the right.
  Widget _buildDesktopLayout(Widget pages) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final destination in destinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  selectedIcon: Icon(destination.selectedIcon),
                  label: Text(destination.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          // Expanded makes the page take up all the remaining width.
          Expanded(child: pages),
        ],
      ),
    );
  }
}
