import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pengajuan_cuti/main.dart';
import 'package:pengajuan_cuti/view/admin/halaman_utama.dart';
import 'package:pengajuan_cuti/view/halaman_login.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_utama.dart';

void main() {
  group('Login Screen', () {
    testWidgets('harus menampilkan layar login', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that login screen is displayed.
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('tampilkan error jika field kosong',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final usernameField = find.byKey(const ValueKey('username_field'));
      final passwordField = find.byKey(const ValueKey('password_field'));
      final roleField = find.byKey(const ValueKey('role_field'));
      final loginButton = find.byKey(const ValueKey('login_button'));

      // Tap login button without filling any fields
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify that error messages are displayed
      expect(find.text('Please enter your username'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
      expect(find.text('Please select your role'), findsOneWidget);
    });
    testWidgets('pindah ke halaman baru jika sudah login',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final usernameField = find.byKey(const ValueKey('username_field'));
      final passwordField = find.byKey(const ValueKey('password_field'));
      final roleField = find.byKey(const ValueKey('role_field'));
      final loginButton = find.byKey(const ValueKey('login_button'));

      await tester.enterText(usernameField, 'username');
      await tester.enterText(passwordField, 'password');
      await tester.tap(roleField);
      await tester.pump();
      await tester.tap(find.text('User'));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byType(HalamanUtama), findsOneWidget);
    });
  });
}
