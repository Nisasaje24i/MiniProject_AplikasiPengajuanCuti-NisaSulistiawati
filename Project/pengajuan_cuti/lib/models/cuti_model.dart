class PengajuanModel {
  int? id;
  String alasan;
  DateTime startDate;
  DateTime endDate;
  String status;
  String nama;
  late String jabatan;
  String alasanAdmin;

  PengajuanModel(
      {this.id,
      required this.nama,
      required this.jabatan,
      required this.alasan,
      required this.startDate,
      required this.endDate,
      this.status = 'Menunggu',
      this.alasanAdmin = 'Menunggu'});
  factory PengajuanModel.fromMap(Map<String, dynamic> map) {
    return PengajuanModel(
        id: map['id'],
        nama: map['nama'],
        jabatan: map['jabatan'],
        alasan: map['alasan'],
        startDate: DateTime.parse(map['start_date']),
        endDate: DateTime.parse(map['end_date']),
        status: map['status'],
        alasanAdmin: map['alasan_admin']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jabatan': jabatan,
      'alasan': alasan,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'alasan_admin': alasanAdmin,
    };
  }

  PengajuanModel copyWith({
    int? id,
    String? alasan,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    String? nama,
    String? jabatan,
    String? alasanAdmin,
  }) {
    return PengajuanModel(
        id: id ?? this.id,
        alasan: alasan ?? this.alasan,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        nama: nama ?? this.nama,
        jabatan: jabatan ?? this.jabatan,
        alasanAdmin: alasanAdmin ?? this.alasanAdmin);
  }
}
