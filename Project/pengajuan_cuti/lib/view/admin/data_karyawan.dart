import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pengajuan_cuti/view_model/karyawan_api.dart';

class DataKaryawan extends StatefulWidget {
  @override
  _DataKaryawanState createState() => _DataKaryawanState();
}

class _DataKaryawanState extends State<DataKaryawan> {
  final _viewModel = DataKaryawanViewModel();
  List<dynamic> _employees = [];

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    final employees = await _viewModel.fetchEmployees();
    setState(() {
      _employees = employees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text('Data Karyawan'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purple,
              Colors.deepPurple,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: _employees.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    _employees[index]['name'],
                    style: GoogleFonts.bentham(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  subtitle: Text(
                    _employees[index]['email'],
                    style: GoogleFonts.bentham(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
