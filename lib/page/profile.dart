import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model_user.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  final ModelUsers currentUser;

  ProfilePage({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    double halfWidth = MediaQuery.of(context).size.width / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAFC8AD),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 370),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Personal information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              // currentUser.username,
                              "Username",
                              style: TextStyle(
                                color: Color(0xFFADD8E6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              currentUser.username,
                              // "Fadhilah Febriani",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Email",
                              style: TextStyle(
                                color: Color(0xFFADD8E6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              currentUser.email,
                              // "fadhilahfebriani@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "No HP",
                              style: TextStyle(
                                color: Color(0xFFADD8E6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              currentUser.no_hp,
                              // "fadhilahfebriani@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Fullname",
                              style: TextStyle(
                                color: Color(0xFFADD8E6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              currentUser.fullname,
                              // "fadhilahfebriani@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Jenis Kelamin",
                              style: TextStyle(
                                color: Color(0xFFADD8E6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              currentUser.jenis_kelamin,
                              // "fadhilahfebriani@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Alamat",
                              style: TextStyle(
                                color: Color(0xFFADD8E6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              currentUser.alamat,
                              // "fadhilahfebriani@gmail.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(currentUser: currentUser)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            // Mengatur padding horizontal menjadi 20
                            vertical: 15,
                          ),
                          backgroundColor: Color(0xFF88AB8E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                color: Color(0xFFAFC8AD),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Set up your profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Update your profile to connect your culture with \n better impression.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'images/img1.jpg',
                      fit: BoxFit.cover,
                      width: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // _buildHeader(),
        ],
      ),
    );
  }
}
