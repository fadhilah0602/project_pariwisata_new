import 'dart:convert';

ModelPariwisata modelPariwisataFromJson(String str) =>
    ModelPariwisata.fromJson(json.decode(str));

String modelPariwisataToJson(ModelPariwisata data) => json.encode(data.toJson());

class ModelPariwisata {
  bool isSuccess;
  String message;
  List<Pariwisata>? data;

  ModelPariwisata({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  factory ModelPariwisata.fromJson(Map<String, dynamic> json) => ModelPariwisata(
    isSuccess: json["isSuccess"],
    message: json["message"] ?? '',
    data: json["data"] != null
        ? List<Pariwisata>.from(json["data"].map((x) => Pariwisata.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data != null
        ? List<dynamic>.from(data!.map((x) => x.toJson()))
        : null,
  };
}

class Pariwisata {
  String id_kategori;
  String id_pariwisata;
  String nama_pariwisata;
  String harga;
  String lokasi;
  String keterangan;
  String gambar;

  Pariwisata({
    required this.id_kategori,
    required this.id_pariwisata,
    required this.nama_pariwisata,
    required this.harga,
    required this.lokasi,
    required this.keterangan,
    required this.gambar,
  });

  factory Pariwisata.fromJson(Map<String, dynamic> json) => Pariwisata(
    id_kategori: json["id_kategori"].toString(),
    id_pariwisata: json["id_pariwisata"].toString(),
    nama_pariwisata: json["nama_pariwisata"] ?? '',
    harga: json["harga"].toString(),
    lokasi: json["lokasi"] ?? '',
    keterangan: json["keterangan"] ?? '',
    gambar: json["gambar"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id_kategori": id_kategori,
    "id_pariwisata": id_pariwisata,
    "nama_pariwisata": nama_pariwisata,
    "harga": harga,
    "lokasi": lokasi,
    "keterangan": keterangan,
    "gambar": gambar,
  };
}
