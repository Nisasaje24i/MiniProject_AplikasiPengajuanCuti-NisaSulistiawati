import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pengajuan_cuti/models/cuti_model.dart';
import 'package:pengajuan_cuti/view_model/db_manager.dart';
import 'package:pengajuan_cuti/view/pegawai/halaman_pengajuan.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatPengajuan extends StatefulWidget {
  const RiwayatPengajuan({
    Key? key,
  }) : super(key: key);

  @override
  _RiwayatPengajuanState createState() => _RiwayatPengajuanState();
}

class _RiwayatPengajuanState extends State<RiwayatPengajuan> {
  bool isEditing = false;

  void editData(PengajuanModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPengajuanCuti(
          pengajuanModel: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pengajuan Cuti')),
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<DbManager>(
              builder: (context, manager, child) {
                final pengajuanItems = manager.pengajuan;
                return Card(
                  color: Colors.deepPurple,
                  child: ListView.builder(
                    itemCount: pengajuanItems.length,
                    itemBuilder: (context, index) {
                      final item = pengajuanItems[index];
                      bool isEditable = item.status != "Disetujui" &&
                          item.status != "Ditolak";
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          title: Text(item.nama,
                              style: GoogleFonts.bentham(
                                  color: Colors.white70, fontSize: 17)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.jabatan,
                                  style: GoogleFonts.bentham(
                                    color: Colors.white70,
                                    fontSize: 17,
                                  )),
                              Text(
                                  'Start Date : ${DateFormat('dd MMMM yyyy').format(item.startDate)}',
                                  style: GoogleFonts.bentham(
                                    color: Colors.white70,
                                    fontSize: 17,
                                  )),
                              Text(
                                  'End Date : ${DateFormat('dd MMMM yyyy').format(item.endDate)}',
                                  style: GoogleFonts.bentham(
                                    color: Colors.white70,
                                    fontSize: 17,
                                  )),
                              Text('Status : ${item.status}',
                                  style: GoogleFonts.bentham(
                                    color: Colors.white70,
                                    fontSize: 17,
                                  )),
                              if (item.status == 'Ditolak')
                                Text(
                                  'Alasan Ditolak : ${item.alasanAdmin}',
                                  style: GoogleFonts.bentham(
                                    color: Colors.white70,
                                    fontSize: 17,
                                  ),
                                ),
                              Text('Alasan Cuti : ${item.alasan}',
                                  style: GoogleFonts.bentham(
                                    color: Colors.white70,
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isEditable)
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text("Delete Confirmation"),
                                          content: Text(
                                              "Are you sure you want to delete ${item.nama}?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                manager
                                                    .deletePengajuan(item.id!);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          '${item.nama} Deleted')),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              if (isEditable)
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: Colors.white,
                                  onPressed: () {
                                    editData(item);
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
