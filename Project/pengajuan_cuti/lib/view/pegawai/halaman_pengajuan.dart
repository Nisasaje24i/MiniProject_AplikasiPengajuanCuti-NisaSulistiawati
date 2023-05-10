import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pengajuan_cuti/view/profile.dart';
import 'package:pengajuan_cuti/models/cuti_model.dart';
import 'package:pengajuan_cuti/view_model/db_manager.dart';
import 'package:pengajuan_cuti/view/admin/list_pengajuan.dart';
import 'package:pengajuan_cuti/view/pegawai/riwayat_pengajuan.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPengajuanCuti extends StatefulWidget {
  final PengajuanModel? pengajuanModel;

  const FormPengajuanCuti({Key? key, this.pengajuanModel}) : super(key: key);

  @override
  _FormPengajuanCutiState createState() => _FormPengajuanCutiState();
}

class _FormPengajuanCutiState extends State<FormPengajuanCuti> {
  final _formKey = GlobalKey<FormState>();

  bool _isUpdate = false;
  late TextEditingController _alasanController;
  late TextEditingController _namaController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedJabatan;
  bool isEdit = true;
  late SharedPreferences logindata;
  String username = '';

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username').toString();
      _namaController.text = username;
    });
  }

  final List<String> _jabatanList = [
    'Direktur Utama',
    'Wakil Direktur Utama',
    'Direktur',
    'Manager',
    'Supervisor',
    'Staff',
    'Karyawan',
    'Office Boy / Office Girl'
  ];

  @override
  void initState() {
    super.initState();
    initial();
    _namaController = TextEditingController();
    _alasanController =
        TextEditingController(text: widget.pengajuanModel?.alasan ?? '');
    _selectedJabatan = widget.pengajuanModel?.jabatan ?? _jabatanList[0];
    _startDateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy')
            .format(widget.pengajuanModel?.startDate ?? DateTime.now()));
    _endDateController = TextEditingController(
        text: DateFormat('dd/MM/yyyy')
            .format(widget.pengajuanModel?.endDate ?? DateTime.now()));
    _startDate = widget.pengajuanModel?.startDate;
    _endDate = widget.pengajuanModel?.endDate;
    _isUpdate = widget.pengajuanModel != null;
  }

  @override
  void dispose() {
    _alasanController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form Pengajuan Cuti"),
      ),
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  maxLines: null,
                  enabled: false,
                  keyboardType: TextInputType.multiline,
                  controller: _namaController,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.purple,
                  value: _selectedJabatan,
                  decoration: const InputDecoration(
                    labelText: 'Jabatan',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                  items: _jabatanList
                      .map(
                        (jabatan) => DropdownMenuItem(
                          child: Text(jabatan),
                          value: jabatan,
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJabatan = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jabatan tidak boleh kosong!';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Mulai',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.date_range,
                      color: Colors.white70,
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _startDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                        );
                        _startDateController.text =
                            DateFormat('dd/MM/yyyy').format(_startDate!);
                      });
                    }
                  },
                  readOnly: true,
                  validator: (value) {
                    if (_startDate == null) {
                      return 'Pilih tanggal mulai cuti';
                    }
                    return null;
                  },
                  controller: _startDateController,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Selesai',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.date_range,
                      color: Colors.white70,
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        _endDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                        );
                        _endDateController.text =
                            DateFormat('dd/MM/yyyy').format(_endDate!);
                      });
                    }
                  },
                  readOnly: true,
                  validator: (value) {
                    if (_endDate == null) {
                      return 'Pilih tanggal selesai cuti';
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return 'Tanggal selesai harus setelah tanggal mulai';
                    }
                    return null;
                  },
                  controller: _endDateController,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Alasan Cuti',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan alasan cuti';
                    }
                    return null;
                  },
                  controller: _alasanController,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (!_isUpdate) {
                      final pengajuan = PengajuanModel(
                          alasan: _alasanController.text,
                          jabatan: _selectedJabatan!,
                          nama: _namaController.text,
                          startDate: _startDate!,
                          endDate: _endDate!,
                          status: 'Menunggu');
                      Provider.of<DbManager>(context, listen: false)
                          .addPengajuan(pengajuan);
                    } else {
                      final pengajuan = PengajuanModel(
                          id: widget.pengajuanModel!.id,
                          alasan: _alasanController.text,
                          jabatan: _selectedJabatan!,
                          nama: _namaController.text,
                          startDate: _startDate!,
                          endDate: _endDate!,
                          status: 'Menunggu');
                      Provider.of<DbManager>(context, listen: false)
                          .updatePengajuan(pengajuan);
                    }
                    _alasanController.clear();
                    _selectedJabatan = null;
                    _startDate = null;
                    _endDate = null;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengajuan berhasil'),
                      ),
                    );
                  },
                  child: Text(_isUpdate ? 'Ubah Pengajuan' : 'Ajukan Cuti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
