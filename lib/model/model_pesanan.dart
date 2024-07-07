import 'dart:convert';

ModelPesanan modelPesananFromJson(String str) =>
    ModelPesanan.fromJson(json.decode(str));

String modelPesananToJson(ModelPesanan data) => json.encode(data.toJson());

class ModelPesanan {
  bool isSuccess;
  List<Pesanan> data;

  ModelPesanan({
    required this.isSuccess,
    required this.data,
  });

  factory ModelPesanan.fromJson(Map<String, dynamic> json) => ModelPesanan(
    isSuccess: json["isSuccess"],
    data: List<Pesanan>.from(json["data"].map((x) => Pesanan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Pesanan {
  int id_pesanan;
  String nama_pariwisata;
  int jumlah;
  int harga;
  int total;
  String gambar;

  Pesanan({
    required this.id_pesanan,
    required this.nama_pariwisata,
    required this.harga,
    required this.jumlah,
    required this.total,
    required this.gambar
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) => Pesanan(
    id_pesanan: json["id_pesanan"],
    nama_pariwisata: json["nama_pariwisata"],
    harga: json["harga"],
    jumlah: json["jumlah"],
    total: json["total"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id_pesanan": id_pesanan,
    "nama_pariwisata": nama_pariwisata,
    "harga": harga,
    "jumlah": jumlah,
    "total": total,
    "gambar": gambar,
  };
}
