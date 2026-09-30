import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:malinkaos/app.dart';

// Sets the size of the fake test screen, and resets it after the test.
void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

// Taps each page in the navigation and checks the right title appears.
Future<void> checkNavigation(WidgetTester tester) async {
  // Dashboard is the first page.
  expect(find.widgetWithText(AppBar, 'Dashboard'), findsOneWidget);

  // Tap the icons rather than the labels, because the word "Projects"
  // also appears on a dashboard card.
  await tester.tap(find.byIcon(Icons.folder_outlined));
  // pumpAndSettle waits until animations and the fake loading are done.
  await tester.pumpAndSettle();
  expect(find.widgetWithText(AppBar, 'Projects'), findsOneWidget);
  expect(find.text('Website redesign'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.settings_outlined));
  await tester.pumpAndSettle();
  expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
}

void main() {
  testWidgets('mobile layout uses a bottom NavigationBar', (tester) async {
    setScreenSize(tester, const Size(400, 800));
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    await checkNavigation(tester);
  });

  testWidgets('desktop layout uses a side NavigationRail', (tester) async {
    setScreenSize(tester, const Size(1200, 800));
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    await checkNavigation(tester);
  });
}
