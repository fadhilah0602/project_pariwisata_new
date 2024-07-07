import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model_user.dart';
import '../util/session_manager.dart';
import 'profile.dart';

class EditProfile extends StatefulWidget {
  final ModelUsers currentUser;

  const EditProfile({required this.currentUser, Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _name;
  String? _email;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  String _jenisKelaminValue = '';
  TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.currentUser.username;
    _emailController.text = widget.currentUser.email; // Inisialisasi nilai email dari model
    _noHpController.text = widget.currentUser.no_hp;
    _fullnameController.text = widget.currentUser.fullname;
    _alamatController.text = widget.currentUser.alamat;
    _jenisKelaminValue = widget.currentUser.jenis_kelamin;
    _roleController.text = widget.currentUser.role;
  }

  void saveChanges(String newUsername, String newEmail, String newNoHp, String newFullname, String newAlamat, String newJenisKelamin , String newRole) async {
    // Validasi input sebelum menyimpan perubahan
    if (newUsername.isEmpty || newEmail.isEmpty || newNoHp.isEmpty || newFullname.isEmpty || newAlamat.isEmpty || newJenisKelamin.isEmpty || newRole.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('All fields are required')));
      return;
    }

    // Trim values to remove any extra spaces
    newUsername = newUsername.trim();
    newEmail = newEmail.trim();
    newNoHp = newNoHp.trim();
    newFullname = newFullname.trim();
    newAlamat = newAlamat.trim();
    newJenisKelamin = newJenisKelamin.trim();

    // Print values for debugging
    print('Sending data:');
    print('Username: $newUsername');
    print('Email: $newEmail');
    print('No HP: $newNoHp');
    print('Fullname: $newFullname');
    print('Alamat: $newAlamat');
    print('Jenis Kelamin: $newJenisKelamin');
    print('Role: $newRole');


    // Validasi format email menggunakan regex
    // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // if (!emailRegex.hasMatch(newEmail)) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Invalid email format')));
    //   return;
    // }

    try {
      var url = Uri.parse('http://192.168.42.233/pariwisata/updateUser.php');
      var response = await http.post(url, body: {
        'id_user': widget.currentUser.id_user.toString(),
        'username': newUsername,
        'email': newEmail,
        'no_hp': newNoHp,
        'fullname': newFullname,
        'alamat': newAlamat,
        'jenis_kelamin': newJenisKelamin,
      });

      var data = json.decode(response.body);

      if (data['is_success']) {
        setState(() {
          widget.currentUser.username = newUsername;
          widget.currentUser.email = newEmail;
          widget.currentUser.no_hp = newNoHp;
          widget.currentUser.fullname = newFullname;
          widget.currentUser.alamat = newAlamat;

          sessionManager.saveSession(
            200,
            widget.currentUser.id_user.toString(),
            newUsername,
            newEmail,
            newNoHp,
            newFullname,
            newAlamat,
            newJenisKelamin,
            newRole,
          );
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
        Navigator.pop(context);

        // Ganti halaman ke halaman profil yang diperbarui
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProfilePage(currentUser: widget.currentUser)),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFAFC8AD),
            title: Text('Edit Profile'),
          ),
          backgroundColor: Color(0xFFAFC8AD),
          body: Form(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 450,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (val) {
                                  return val!.isEmpty
                                      ? "Name Tidak Boleh kosong"
                                      : null;
                                },
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Name',
                                  suffixIcon: _name != null && _name!.isNotEmpty
                                      ? Icon(Icons.check, color: Colors.blue)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value.trim();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 450,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (val) {
                                  return val!.isEmpty
                                      ? "Email Tidak Boleh kosong"
                                      : null;
                                },
                                controller: _emailController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Email',
                                  suffixIcon: _email != null &&
                                      _email!.isNotEmpty
                                      ? Icon(Icons.check, color: Colors.blue)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 450,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (val) {
                                  return val!.isEmpty
                                      ? "Name Tidak Boleh kosong"
                                      : null;
                                },
                                controller: _noHpController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'No Telp',
                                  suffixIcon: _name != null && _name!.isNotEmpty
                                      ? Icon(Icons.check, color: Colors.blue)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value.trim();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 450,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (val) {
                                  return val!.isEmpty
                                      ? "Name Tidak Boleh kosong"
                                      : null;
                                },
                                controller: _fullnameController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Fullname',
                                  suffixIcon: _name != null && _name!.isNotEmpty
                                      ? Icon(Icons.check, color: Colors.blue)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value.trim();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 450,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (val) {
                                  return val!.isEmpty
                                      ? "Name Tidak Boleh kosong"
                                      : null;
                                },
                                controller: _alamatController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: 'Alamat',
                                  suffixIcon: _name != null && _name!.isNotEmpty
                                      ? Icon(Icons.check, color: Colors.blue)
                                      : null,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value.trim();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 450,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintText: 'Jenis Kelamin ',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                ),
                                value: _jenisKelaminValue.isNotEmpty ? _jenisKelaminValue : null,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _jenisKelaminValue = newValue!;
                                  });
                                },
                                items: <String>['Laki-Laki', 'Perempuan']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width:
                              MediaQuery.of(context).size.width - (2 * 98),
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 7,
                                  backgroundColor: Color(0xFF88AB8E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  // Implement logic to save changes
                                  String newUsername = _usernameController.text;
                                  String newFullname = _fullnameController.text;
                                  String newJenisKelamin = _jenisKelaminValue;
                                  String newNoHp = _noHpController.text;
                                  String newAlamat = _alamatController.text;
                                  String newEmail = _emailController.text; // Ambil nilai dari controller email
                                  String newRole = _roleController.text;

                                  // Panggil fungsi untuk menyimpan perubahan
                                  saveChanges(newUsername,newFullname, newJenisKelamin, newNoHp, newAlamat, newEmail,newRole);
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
