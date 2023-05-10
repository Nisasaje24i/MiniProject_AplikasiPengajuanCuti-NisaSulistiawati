import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pengajuan_cuti/view/profile.dart';
import 'package:pengajuan_cuti/view/admin/list_pengajuan.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_pengajuan.dart';
import 'package:pengajuan_cuti/view/pegawai/riwayat_pengajuan.dart';

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Home(),
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

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                          builder: (context) => const FormPengajuanCuti(),
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
                            Icons.assignment,
                            size: 50.0,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Ajukan Cuti',
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
                          builder: (context) => const RiwayatPengajuan(),
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
                            Icons.history,
                            size: 50.0,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Riwayat Pengajuan',
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
