import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myAster/features/home/presentation/view/bottom_view/setting_view.dart';

void main() {
  testWidgets('✅ Settings screen displays all options correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // ✅ Verify all setting options
    expect(find.text("Notifications"), findsOneWidget);
    expect(find.text("Manage notifications settings"), findsOneWidget);
    expect(find.text("Privacy"), findsOneWidget);
    expect(find.text("Manage privacy settings"), findsOneWidget);
    expect(find.text("Language"), findsOneWidget);
    expect(find.text("Change app language"), findsOneWidget);
    expect(find.text("Help & Support"), findsOneWidget);
    expect(find.text("Get assistance with the app"), findsOneWidget);

    // ✅ Verify all icons exist
    expect(find.byIcon(Icons.notifications), findsOneWidget);
    expect(find.byIcon(Icons.privacy_tip), findsOneWidget);
    expect(find.byIcon(Icons.language), findsOneWidget);
    expect(find.byIcon(Icons.help), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(4)); // 4 icons
  });

  testWidgets('✅ Tapping settings options triggers interactions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // ✅ Tap "Notifications"
    await tester.tap(find.text("Notifications"));
    await tester.pump();

    // ✅ Tap "Privacy"
    await tester.tap(find.text("Privacy"));
    await tester.pump();

    // ✅ Tap "Language"
    await tester.tap(find.text("Language"));
    await tester.pump();

    // ✅ Tap "Help & Support"
    await tester.tap(find.text("Help & Support"));
    await tester.pump();

    // Test passes if no exceptions occur
  });

  testWidgets('✅ All list tiles are tappable and do not throw errors',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // ✅ Verify that tapping all ListTiles doesn't cause crashes
    final listTiles = find.byType(ListTile);
    expect(listTiles, findsNWidgets(4)); // 4 setting options

    for (var i = 0; i < 4; i++) {
      await tester.tap(listTiles.at(i));
      await tester.pump();
    }
  });

  testWidgets('✅ ListView scrolls properly when content overflows screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 200, // Simulate small screen height
            child: SettingsScreen(),
          ),
        ),
      ),
    );

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    // ✅ Scroll down and verify it scrolls without errors
    await tester.drag(listViewFinder, const Offset(0, -200));
    await tester.pump();
  });

  // testWidgets('✅ SettingsScreen has a consistent UI layout',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     const MaterialApp(
  //       home: SettingsScreen(),
  //     ),
  //   );

  //   final listViewFinder = find.byType(ListView);
  //   expect(listViewFinder, findsOneWidget);

  //   // ✅ Ensure ListTiles have expected padding and layout
  //   final listTile = find.byType(ListTile).first;
  //   final tileWidget = tester.widget<ListTile>(listTile);
  //   expect(tileWidget.contentPadding, isNotNull);
  // });

  testWidgets('✅ SettingsScreen shows correct trailing icons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // ✅ Verify that each setting has a trailing "arrow" icon
    expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(4));
  });

  testWidgets('✅ SettingsScreen does not show unexpected elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // ✅ Ensure that an unexpected text does NOT exist
    expect(find.text("Random Setting"), findsNothing);
    expect(find.text("Hidden Option"), findsNothing);
  });

  testWidgets('✅ SettingsScreen renders on different screen sizes',
      (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 600)); // Medium screen
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    await tester.binding.setSurfaceSize(const Size(400, 800)); // Small screen
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    await tester.binding.setSurfaceSize(const Size(1200, 900)); // Large screen
    await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));

    expect(find.byType(SettingsScreen), findsWidgets);
  });
}
