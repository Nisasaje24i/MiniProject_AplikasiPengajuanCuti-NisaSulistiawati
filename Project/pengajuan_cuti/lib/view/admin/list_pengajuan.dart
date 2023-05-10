import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pengajuan_cuti/view_model/db_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDataPengajuan extends StatefulWidget {
  const ListDataPengajuan({
    Key? key,
  }) : super(key: key);

  @override
  State<ListDataPengajuan> createState() => _ListDataPengajuanState();
}

class _ListDataPengajuanState extends State<ListDataPengajuan> {
  String _alasanDitolak = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pengajuan Cuti')),
      backgroundColor: Colors.deepPurple,
      body: Stack(children: [
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
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          item.nama,
                          style: GoogleFonts.bentham(
                            color: Colors.white70,
                            fontSize: 19,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.jabatan,
                              style: GoogleFonts.bentham(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Start Date : ${DateFormat('dd MMMM yyyy').format(item.startDate)}',
                              style: GoogleFonts.bentham(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'End Date : ${DateFormat('dd MMMM yyyy').format(item.endDate)}',
                              style: GoogleFonts.bentham(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Status : ${item.status}',
                              style: GoogleFonts.bentham(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Alasan Cuti : ${item.alasan}',
                              style: GoogleFonts.bentham(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.white,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Delete Confirmation"),
                                      content: Text(
                                          "Are you sure you want to delete ${item.alasan}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            manager.deletePengajuan(item.id!);
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      '${item.alasan} Deleted')),
                                            );
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            if (item.status == 'Menunggu')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.cancel_outlined),
                                    color: Colors.red,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Pengajuan Ditolak'),
                                            content: TextField(
                                              decoration: const InputDecoration(
                                                  labelText: 'Alasan ditolak',
                                                  hintText:
                                                      'Masukkan alasan ditolak'),
                                              onChanged: (value) {
                                                setState(() {
                                                  _alasanDitolak = value;
                                                });
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();

                                                  manager.updatePengajuanStatus(
                                                      item.id!,
                                                      'Ditolak',
                                                      _alasanDitolak);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.check_box_rounded),
                                    color: Colors.green,
                                    onPressed: () {
                                      manager.updatePengajuanStatus(item.id!,
                                          'Disetujui', _alasanDitolak);
                                    },
                                  ),
                                ],
                              )
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
      ]),
    );
  }
}
