import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pengajuan_cuti/view/admin/data_karyawan.dart';
import 'package:pengajuan_cuti/view/profile.dart';
import 'package:pengajuan_cuti/view/admin/list_pengajuan.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_pengajuan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanUtamaAdmin extends StatefulWidget {
  @override
  State<HalamanUtamaAdmin> createState() => _HalamanUtamaAdminState();
}

class _HalamanUtamaAdminState extends State<HalamanUtamaAdmin> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeAdmin(),
    const ProfileSheet(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pengajuan Cuti',
          style: GoogleFonts.kalam(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 70.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/pengajuan.png',
              height: 200.0,
              width: 200.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Selamat datang di aplikasi pengajuan cuti',
              style: GoogleFonts.kalam(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 30.0,
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DataKaryawan(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.people_rounded,
                            size: 50.0,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Data Karyawan',
                            style: GoogleFonts.kalam(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListDataPengajuan(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.format_list_bulleted_sharp,
                            size: 50.0,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'List Pengajuan',
                            style: GoogleFonts.kalam(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
