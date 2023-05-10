import 'package:flutter/material.dart';
import 'package:pengajuan_cuti/view/splashscreen.dart';
import 'package:pengajuan_cuti/view_model/db_manager.dart';
import 'package:pengajuan_cuti/view/admin/halaman_utama.dart';
import 'package:pengajuan_cuti/view/halaman_login.dart';
import 'package:pengajuan_cuti/view/admin/list_pengajuan.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_utama.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_pengajuan.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => DbManager(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Pengajuan Cuti',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashScreen(),
      routes: {
        '/admin': (context) => HalamanUtamaAdmin(),
        '/user': (context) => HalamanUtama(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
