import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model_user.dart';

class AuthService with ChangeNotifier {
  ModelUsers? _currentUser;

  ModelUsers? get currentUser => _currentUser;

  void setCurrentUser(ModelUsers user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('http://192.168.43.99/pariwisata/login.php'); // Ganti dengan URL API Anda
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        _currentUser = ModelUsers(
          id_user: userData['id_user'],
          username: userData['username'],
          email: userData['email'],
          no_hp: userData['no_hp'],
          jenis_kelamin: userData['jenis_kelamin'],
          alamat: userData['alamat'],
          fullname: userData['fullname'],
          role: userData['role'],
        );
        notifyListeners();
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print(e);
      throw Exception('Invalid credentials');
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
