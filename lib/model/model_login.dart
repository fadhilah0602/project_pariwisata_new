import 'dart:convert';

ModelLogin modelLoginFromJson(String str) =>
    ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  bool sukses;
  int status;
  String pesan;
  Data data;

  ModelLogin({
    required this.sukses,
    required this.status,
    required this.pesan,
    required this.data,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    sukses: json["sukses"] ?? false,
    status: json["status"] ?? 0,
    pesan: json["pesan"] ?? "",
    data: json["data"] != null
        ? Data.fromJson(json["data"])
        : Data(
      id_user: "",
      username: "",
      fullname: "",
      jenis_kelamin: "",
      no_hp: "",
      alamat: "",
      email: "",
      role: "",
      password: "",
    ),
  );

  Map<String, dynamic> toJson() => {
    "sukses": sukses,
    "status": status,
    "pesan": pesan,
    "data": data.toJson(),
  };
}

class Data {
  String id_user;
  String username;
  String fullname;
  String jenis_kelamin;
  String no_hp;
  String alamat;
  String email;
  String role;
  String password;

  Data({
    required this.id_user,
    required this.username,
    required this.fullname,
    required this.jenis_kelamin,
    required this.no_hp,
    required this.alamat,
    required this.email,
    required this.role,
    required this.password,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id_user: json["id_user"]?.toString() ?? "",
    username: json["username"] ?? "",
    fullname: json["fullname"] ?? "",
    jenis_kelamin: json["jenis_kelamin"] ?? "",
    no_hp: json["no_hp"] ?? "",
    alamat: json["alamat"] ?? "",
    email: json["email"] ?? "",
    role: json["role"] ?? "",
    password: json["password"] ?? "",
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
    "password": password,
  };
}
