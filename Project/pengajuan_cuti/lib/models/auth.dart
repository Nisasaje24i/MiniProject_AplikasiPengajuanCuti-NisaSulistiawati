import 'package:pengajuan_cuti/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final Auth _instance = Auth._internal();
  late SharedPreferences _prefs;

  factory Auth() {
    return _instance;
  }

  Auth._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> login(String username, String password, String role) async {
    _prefs.setString('username', username);
    _prefs.setString('password', password);
    _prefs.setString('role', role);

    return true;
  }

  UserModel? get currentUser {
    final username = _prefs.getString('username');
    final password = _prefs.getString('password');
    final role = _prefs.getString('role');
    if (username != null && password != null && role != null) {
      return UserModel(username: username, password: password, role: role);
    }
    return null;
  }
}
