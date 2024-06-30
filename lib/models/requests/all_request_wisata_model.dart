import 'dart:convert';

class AllRequestWisataModel {
    final String nama_wisata;
    final String gambar;
    final String jam_layanan;
    final String jam_tutup;
    final String alamat;
    int? id;

    AllRequestWisataModel({
        required this.nama_wisata,
        required this.gambar,
        required this.jam_layanan,
        required this.jam_tutup,
        required this.alamat,
        this.id,
    });

    factory AllRequestWisataModel.fromRawJson(String str) => AllRequestWisataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllRequestWisataModel.fromJson(Map<String, dynamic> json) => AllRequestWisataModel(
        nama_wisata: json["nama_wisata"],
        gambar: json["gambar"],
        jam_layanan: json["jam_layanan"],
        jam_tutup: json["jam_tutup"],
        alamat: json["alamat"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
      "nama_wisata": nama_wisata,
      "gambar": gambar,
      "jam_layanan": jam_layanan,
      "jam_tutup": jam_tutup,
      "alamat": alamat,
      "id": id,
    };
}
