import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_utama.dart';

void main() {
  testWidgets('Test UI home page', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Home()));

    expect(find.text('Pengajuan Cuti'), findsOneWidget);
    expect(find.text('Ajukan Cuti'), findsOneWidget);
    expect(find.text('Riwayat Pengajuan'), findsOneWidget);

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2));
    expect(find.byType(InkWell), findsNWidgets(2));
    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
