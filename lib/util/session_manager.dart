import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? id_user;
  String? username;
  String? fullname;
  String? jenis_kelamin;
  String? no_hp;
  String? alamat;
  String? email;
  String? role;

  Future<void> saveSession(
      int val, String id_user, String username, String fullname, String jenis_kelamin, String no_hp, String alamat, String email, String role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setString("id_user", id_user);
    pref.setString("username", username);
    pref.setString("fullname", fullname);
    pref.setString("jenis_kelamin", jenis_kelamin);
    pref.setString("no_hp", no_hp);
    pref.setString("alamat", alamat);
    pref.setString("email", email);
    pref.setString("role", role);
  }

  Future<bool> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    id_user = pref.getString("id_user");
    username = pref.getString("username");
    fullname = pref.getString("fullname");
    jenis_kelamin = pref.getString("jenis_kelamin");
    no_hp = pref.getString("no_hp");
    alamat = pref.getString("alamat");
    email = pref.getString("email");
    role = pref.getString("role");

    print('Log sess id_user : $id_user');
    print('Log sess username : $username');
    print('Log sess username : $email');

    return email != null;
  }

  Future<void> clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

SessionManager sessionManager = SessionManager();