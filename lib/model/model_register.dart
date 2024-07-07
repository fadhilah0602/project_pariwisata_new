import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) =>
    ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
  int value;
  String username;
  String fullname;
  String jenis_kelamin;
  String no_hp;
  String alamat;
  String email;
  String role;
  String password;
  String message;

  ModelRegister({
    required this.value,
    required this.username,
    required this.fullname,
    required this.jenis_kelamin,
    required this.no_hp,
    required this.alamat,
    required this.email,
    required this.role,
    required this.password,
    required this.message,
  });

  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
    value: json["value"] ?? 0,
    username: json["username"] ?? "",
    fullname: json["fullname"] ?? "",
    jenis_kelamin: json["jenis_kelamin"] ?? "",
    no_hp: json["no_hp"] ?? "",
    alamat: json["alamat"] ?? "",
    email: json["email"] ?? "",
    role: json["role"] ?? "",
    password: json["password"] ?? "",
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "username": username,
    "fullname": fullname,
    "jenis_kelamin": jenis_kelamin,
    "no_hp": no_hp,
    "alamat": alamat,
    "email": email,
    "role": role,
    "password": password,
    "message": message,
  };
}


// import 'dart:convert';
//
// ModelRegister modelRegisterFromJson(String str) =>
//     ModelRegister.fromJson(json.decode(str));
//
// String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());
//
// class ModelRegister {
//   int value;
//   String username;
//   String fullname;
//   String jenis_kelamin;
//   String no_hp;
//   String alamat;
//   String email;
//   String role;
//   String password;
//   String message;
//
//   ModelRegister({
//     required this.value,
//     required this.username,
//     required this.fullname,
//     required this.jenis_kelamin,
//     required this.no_hp,
//     required this.alamat,
//     required this.email,
//     required this.role,
//     required this.password,
//     required this.message,
//   });
//
//   factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
//     value: json["value"],
//     username: 'json["username"]',
//     fullname: 'json["fullname"]',
//     jenis_kelamin: 'json["jenis_kelamin"]',
//     no_hp: 'json["no_hp"]',
//     alamat: 'json["alamat"]',
//     email: 'json["email"]',
//     role: 'json["role"]',
//     password: 'json["password"]',
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "value": value,
//     "username": username,
//     "fullname": fullname,
//     "jenis_kelamin": jenis_kelamin,
//     "no_hp": no_hp,
//     "alamat": alamat,
//     "email": email,
//     "role": role,
//     "password": password,
//     "message": message,
//   };
// }


