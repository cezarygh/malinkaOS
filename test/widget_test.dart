import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:malinkaos/app.dart';
import 'package:malinkaos/shared/navigation/app_bottom_bar.dart';
import 'package:malinkaos/shared/navigation/app_side_bar.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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

  // Tap the icons rather than the labels, because each label also
  // appears in the page's app bar and body.
  await tester.tap(find.byIcon(Icons.folder_outlined));
  // pumpAndSettle waits until the page-switch animations are done.
  await tester.pumpAndSettle();
  expect(find.widgetWithText(AppBar, 'Projects'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.settings_outlined));
  await tester.pumpAndSettle();
  expect(find.widgetWithText(AppBar, 'Settings'), findsOneWidget);
}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('mobile layout uses the floating AppBottomBar', (tester) async {
    setScreenSize(tester, const Size(400, 800));
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(AppBottomBar), findsOneWidget);
    expect(find.byType(AppSideBar), findsNothing);
    await checkNavigation(tester);
  });

  testWidgets('desktop layout uses the AppSideBar', (tester) async {
    setScreenSize(tester, const Size(1200, 800));
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(AppSideBar), findsOneWidget);
    expect(find.byType(AppBottomBar), findsNothing);
    await checkNavigation(tester);
  });
}
