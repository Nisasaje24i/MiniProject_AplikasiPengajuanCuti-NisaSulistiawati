import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pengajuan_cuti/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;
  bool _isLoading = false;
  final Auth _auth = Auth();
  late SharedPreferences logindata;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    _auth.init();
    checkLogin();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Username / Password harus diisi'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      return;
    } else if (username.trim().split(' ').length < 2) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Username minimal 2 kata dan harus berdasarkan nama lengkap!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      return;
    }

    final success = _selectedRole != null
        ? await _auth.login(username, password, _selectedRole!)
        : false;

    if (success) {
      logindata = await SharedPreferences.getInstance();
      logindata.setBool('isLoggedIn', true);
      logindata.setString('username', username);
      logindata.setString('password', password);
      logindata.setString('role', _selectedRole!);

      switch (_selectedRole) {
        case 'admin':
          Navigator.pushReplacementNamed(context, '/admin');
          break;
        case 'user':
          Navigator.pushReplacementNamed(context, '/user');
          break;
        default:
          break;
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    bool isLoggedIn = logindata.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      String username = logindata.getString('username') ?? '';
      String password = logindata.getString('password') ?? '';
      String role = logindata.getString('role') ?? '';
      _usernameController.text = username;
      _passwordController.text = password;
      setState(() {
        _selectedRole = role;
        _isLoading = true;
      });
      await _auth.login(username, password, role);
      switch (role) {
        case 'admin':
          Navigator.pushReplacementNamed(context, '/admin');
          break;
        case 'user':
          Navigator.pushReplacementNamed(context, '/user');
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.kalam(
                          color: Colors.white70,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/login.webp',
                    height: 120,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    items: const [
                      DropdownMenuItem(
                        child: Text(
                          'Admin',
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: 'admin',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'User',
                          style: const TextStyle(color: Colors.white),
                        ),
                        value: 'user',
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      prefixIcon: Icon(
                        Icons.people_outline,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Harap pilih role' : null,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('LOGIN'),
                  ),
                ],
              ),
            ),
    );
  }
}
