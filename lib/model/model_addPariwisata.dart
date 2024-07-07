import 'dart:convert';

ModelAddPariwisata modelAddPariwisataFromJson(String str) =>
    ModelAddPariwisata.fromJson(json.decode(str));

String modelAddPariwisataToJson(ModelAddPariwisata data) =>
    json.encode(data.toJson());

class ModelAddPariwisata {

  bool isSuccess;
  String message;

  ModelAddPariwisata({
    required this.isSuccess,
    required this.message,
  });

  factory ModelAddPariwisata.fromJson(Map<String, dynamic> json) =>
      ModelAddPariwisata(
        isSuccess: json["isSuccess"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
  };
}
