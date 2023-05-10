import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSheet extends StatefulWidget {
  const ProfileSheet({Key? key}) : super(key: key);
  @override
  State<ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<ProfileSheet> {
  late SharedPreferences logindata;
  String username = '';

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                const SizedBox(height: 15),
                Text(
                  username,
                  style: GoogleFonts.bentham(
                      color: Colors.white70,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: GoogleFonts.bentham(
                        color: Colors.white70,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "I'm a person who enjoys exploring new places and trying different foods. I also like to keep up with technology and programmer-related developments, and am active in several outside organizations. In addition to employees, I am also a writer on several novel applications.",
                    style: GoogleFonts.bentham(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Skills',
                    style: GoogleFonts.bentham(
                        color: Colors.white70,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildSkill('Flutter'),
                      _buildSkill('Dart'),
                      _buildSkill('Kotlin'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildSkill('C++/C'),
                      _buildSkill('HTML'),
                      _buildSkill('CSS'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              logindata = await SharedPreferences.getInstance();
              logindata.clear();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Logout',
              style: GoogleFonts.bentham(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkill(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.purple,
      ),
      child: Text(
        skill,
        style: GoogleFonts.bentham(
            color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}
