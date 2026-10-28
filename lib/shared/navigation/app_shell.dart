import 'package:flutter/material.dart';

import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/projects/presentation/projects_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../layout/breakpoints.dart';
import '../theme/nav_colors.dart';
import 'app_bottom_bar.dart';
import 'app_side_bar.dart';
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
// whether to show a bottom bar (mobile) or a side bar (desktop).
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

  // Mobile: the page fills the screen with a floating bar at the bottom.
  Widget _buildMobileLayout(Widget pages) {
    return Scaffold(
      // extendBody lets the page continue behind the floating bar, so you
      // can see the page around the rounded pill. Lists still get enough
      // bottom space to scroll their last item above the bar.
      extendBody: true,
      body: pages,
      bottomNavigationBar: AppBottomBar(
        destinations: destinations,
        selectedIndex: _selectedIndex,
        onSelected: _onDestinationSelected,
      ),
    );
  }

  // Desktop: a side bar card on the left, the page on the right.
  Widget _buildDesktopLayout(Widget pages) {
    return Scaffold(
      backgroundColor: NavColors.of(context).background,
      body: Row(
        // start: the side bar sits at the top instead of the middle.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            right: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
              child: AppSideBar(
                destinations: destinations,
                selectedIndex: _selectedIndex,
                onSelected: _onDestinationSelected,
              ),
            ),
          ),
          // Expanded makes the page take up all the remaining width.
          Expanded(child: pages),
        ],
      ),
    );
  }
}
