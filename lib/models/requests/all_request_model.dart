import 'dart:convert';

class AllRequestModel {
    final String namaApartemen;
    final String alamat;
    final String gambar;
    int? id;

    AllRequestModel({
        required this.namaApartemen,
        required this.alamat,
        required this.gambar,
        this.id,
    });

    factory AllRequestModel.fromRawJson(String str) => AllRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllRequestModel.fromJson(Map<String, dynamic> json) => AllRequestModel(
        namaApartemen: json["nama_apartemen"],
        alamat: json["alamat"],
        gambar: json["gambar"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nama_apartemen": namaApartemen,
        "alamat": alamat,
        "gambar": gambar,
        "id": id,
    };
}
