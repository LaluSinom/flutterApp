import 'dart:convert';

class GetApartemenResponseModel {
    final int status;
    final List<Result> result;

    GetApartemenResponseModel({
        required this.status,
        required this.result,
    });

    factory GetApartemenResponseModel.fromRawJson(String str) => GetApartemenResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetApartemenResponseModel.fromJson(Map<String, dynamic> json) => GetApartemenResponseModel(
        status: json["status"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Result {
    final String id;
    final String namaApartemen;
    final String alamat;
    final String gambar;

    Result({
        required this.id,
        required this.namaApartemen,
        required this.alamat,
        required this.gambar,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        namaApartemen: json["nama_apartemen"],
        alamat: json["alamat"],
        gambar: json["gambar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_apartemen": namaApartemen,
        "alamat": alamat,
        "gambar": gambar,
    };
}
