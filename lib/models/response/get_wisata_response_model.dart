import 'dart:convert';

class GetWisataResponseModel {
    final int status;
    final List<Wisata> result;

    GetWisataResponseModel({
        required this.status,
        required this.result,
    });

    factory GetWisataResponseModel.fromRawJson(String str) => GetWisataResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetWisataResponseModel.fromJson(Map<String, dynamic> json) => GetWisataResponseModel(
        status: json["status"],
        result: List<Wisata>.from(json["result"].map((x) => Wisata.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
    };
}

class Wisata {
    final String namaWisata;
    final String gambar;
    final String jamLayanan;
    final String jamTutup;
    final String alamat;
    final String id;

    Wisata({
        required this.namaWisata,
        required this.gambar,
        required this.jamLayanan,
        required this.jamTutup,
        required this.alamat,
        required this.id,
    });

    factory Wisata.fromRawJson(String str) => Wisata.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
        namaWisata: json["nama_wisata"],
        gambar: json["gambar"],
        jamLayanan: json["jam_layanan"],
        jamTutup: json["jam_tutup"],
        alamat: json["alamat"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nama_wisata": namaWisata,
        "gambar": gambar,
        "jam_layanan": jamLayanan,
        "jam_tutup": jamTutup,
        "alamat": alamat,
        "id": id,
    };
}
