import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pengajuan_cuti/main.dart';

void main() {
  testWidgets('Login UI test', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(MyApp());
    expect(find.widgetWithText(TextFormField, 'Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
  });
}
