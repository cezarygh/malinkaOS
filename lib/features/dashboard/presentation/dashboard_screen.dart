import 'package:flutter/material.dart';

import '../../../shared/layout/breakpoints.dart';
import 'widgets/summary_card.dart';

// The first page of the app. For now it shows placeholder numbers;
// later they can come from the database through the api/ folder.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Decide how many cards fit next to each other for a given width.
  int _columnsForWidth(double width) {
    if (width < mobileBreakpoint) {
      return 1;
    } else if (width < desktopBreakpoint) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 16;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(spacing),
        // LayoutBuilder tells us how much width this page actually has
        // (the screen width minus the navigation rail on desktop).
        child: LayoutBuilder(
          builder: (context, constraints) {
            final int columns = _columnsForWidth(constraints.maxWidth);
            final double cardWidth =
                (constraints.maxWidth - spacing * (columns - 1)) / columns;

            // Wrap places children in a row and moves them to a new line
            // when there is no more room.
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: const SummaryCard(
                    title: 'Projects',
                    value: '3',
                    icon: Icons.folder,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const SummaryCard(
                    title: 'In progress',
                    value: '1',
                    icon: Icons.timelapse,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: const SummaryCard(
                    title: 'Completed',
                    value: '1',
                    icon: Icons.check_circle,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
