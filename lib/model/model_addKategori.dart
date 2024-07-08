import 'dart:convert';

ModelAddKategori modelAddKategoriFromJson(String str) =>
    ModelAddKategori.fromJson(json.decode(str));

String modelAddKategoriToJson(ModelAddKategori data) =>
    json.encode(data.toJson());

class ModelAddKategori {

  bool isSuccess;
  String message;

  ModelAddKategori({
    required this.isSuccess,
    required this.message,
  });

  factory ModelAddKategori.fromJson(Map<String, dynamic> json) =>
      ModelAddKategori(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}
