import 'dart:convert';

List<ModelUsers> modelUsersFromJson(String str) =>
    List<ModelUsers>.from(json.decode(str).map((x) => ModelUsers.fromJson(x)));

String modelUsersToJson(List<ModelUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelUsers {
  String id_user;
  String username;
  String fullname;
  String jenis_kelamin;
  String no_hp;
  String alamat;
  String email;
  String role;

  ModelUsers({
    required this.id_user,
    required this.username,
    required this.fullname,
    required this.jenis_kelamin,
    required this.no_hp,
    required this.alamat,
    required this.email,
    required this.role,
  });

  factory ModelUsers.fromJson(Map<String, dynamic> json) => ModelUsers(
    id_user: json["id_user"],
    username: json["username"],
    fullname: json["fullname"],
    jenis_kelamin: json["jenis_kelamin"],
    no_hp: json["no_hp"],
    alamat: json["alamat"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": id_user,
    "username": username,
    "fullname": fullname,
    "jenis_kelamin": jenis_kelamin,
    "no_hp": no_hp,
    "alamat": alamat,
    "email": email,
    "role": role,
  };
}

// class ModelUsers {
//   final String id_user;
//   late final String username;
//   late final String email;
//   late final String no_hp;
//   late final String fullname;
//   late final String alamat;
//   final String role;
//   late final String jenis_kelamin;
//
//   ModelUsers({
//     required this.id_user,
//     required this.username,
//     required this.email,
//     required this.no_hp,
//     required this.fullname,
//     required this.alamat,
//     required this.role,
//     required this.jenis_kelamin,
//   });
// }

