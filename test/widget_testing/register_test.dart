import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myasteer/features/auth/presentation/view/signup_page.dart';

void main() {
  testWidgets("Register", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SignUpPage(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), "Rohan");
    await tester.tap(find.byType(ElevatedButton).at(0));
    await tester.pumpAndSettle();

    expect(find.text("Invalid"), findsOneWidget);
  });
}
