import 'package:flutter/material.dart';

import '../model/model_user.dart';
import '../util/session_manager.dart';
import 'legal_policies.dart';
import 'profile.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late ModelUsers currentUser;

  @override
  void initState() {
    super.initState();
    getDataSession();
  }

  Future<void> getDataSession() async {
    bool hasSession = await sessionManager.getSession();
    if (hasSession) {
      setState(() {
        currentUser = ModelUsers(
          id_user: sessionManager.id_user!,
          username: sessionManager.username!,
          email: sessionManager.email!,
          no_hp: sessionManager.no_hp!,
          fullname: sessionManager.fullname!,
          alamat: sessionManager.alamat!,
          role: sessionManager.role!,
          jenis_kelamin: sessionManager.jenis_kelamin!,
        );
      });
    } else {
      print('Log Session tidak ditemukan!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Color(0xFF87CEEB), // Sesuaikan dengan warna tema aplikasi Anda
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle('Account Settings'),
            _buildListItem(context, Icons.person, 'Profile', trailingIcon: Icons.navigate_next, onTap: () {
              // Navigasi ke halaman ProfilePage dengan mengirim currentUser
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(currentUser: currentUser)));
            }),
            _buildListItem(context, Icons.security_outlined, 'Legal and Policies', trailingIcon: Icons.navigate_next, onTap: () {
              // Navigasi ke halaman LegalAndPoliciesPage
              Navigator.push(context, MaterialPageRoute(builder: (context) => LegalAndPoliciesPage()));
            }),
            SizedBox(height: 20), // Jarak antara daftar item dan tombol logout
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData leadingIcon, String title, {String trailingText = '', IconData? trailingIcon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color.fromARGB(241, 235, 223, 223)),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          leading: Icon(leadingIcon),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Rubik',
                color: Color.fromRGBO(103, 114, 148, 1)
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailingText.isNotEmpty)
                Text(
                  trailingText,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      color: Color.fromRGBO(103, 114, 148, 1)
                  ),
                ),
              if (trailingIcon != null && trailingText.isNotEmpty) SizedBox(width: 8),
              if (trailingIcon != null) Icon(trailingIcon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {
        // Implement logout action here
        // Example: Clear session and navigate to login screen
        sessionManager.clearSession();
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false); // Navigasi ke halaman login dan hapus history route
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromARGB(241, 235, 223, 223)),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          leading: Icon(Icons.logout),
          title: Text(
            'Logout',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Rubik',
                color: Color.fromRGBO(103, 114, 148, 1)
            ),
          ),
          trailing: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
