import 'dart:convert';

import 'package:http/http.dart' as http;

class DataKaryawanViewModel {
  Future<List<dynamic>> fetchEmployees() async {
    final response = await http
        .get(Uri.parse('https://645b36ea99b618d5f3152b45.mockapi.io/pegawai'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch employees');
    }
  }
}
