import 'package:flutter/material.dart';
import 'package:pengajuan_cuti/helper/database_helper.dart';
import 'package:pengajuan_cuti/models/cuti_model.dart';
import 'package:pengajuan_cuti/models/user.dart';

class DbManager extends ChangeNotifier {
  List<PengajuanModel> _pengajuanModel = [];
  late DatabaseHelper _dbHelper;

  List<PengajuanModel> get pengajuan => _pengajuanModel;

  DbManager() {
    _dbHelper = DatabaseHelper();
    _getAllPengajuan();
  }

  void _getAllPengajuan() async {
    _pengajuanModel = await _dbHelper.getPengajuan();
    notifyListeners();
  }

  Future<void> addPengajuan(PengajuanModel pengajuanModel) async {
    await _dbHelper.insertPengajuan(pengajuanModel);
    _getAllPengajuan();
  }

  void updatePengajuan(PengajuanModel pengajuanModel) async {
    await _dbHelper.updatePengajuan(pengajuanModel);
    _getAllPengajuan();
  }

  Future<PengajuanModel> getPengajuanById(int id) async {
    return await _dbHelper.getPengajuanById(id);
  }

  Future<void> updatePengajuanStatus(
      int id, String status, String alasanAdmin) async {
    final pengajuan = await _dbHelper.getPengajuanById(id);
    final updatedPengajuan =
        pengajuan.copyWith(status: status, alasanAdmin: alasanAdmin);
    await _dbHelper.updatePengajuanStatus(id, status, alasanAdmin);
    _getAllPengajuan();
  }

  void editPengajuan(int id, String status, String alasanAdmin) async {
    await _dbHelper.updatePengajuanStatus(id, status, alasanAdmin);
    _getAllPengajuan();
  }

  void deletePengajuan(int id) async {
    await _dbHelper.deletePengajuan(id);
    _getAllPengajuan();
  }
}
