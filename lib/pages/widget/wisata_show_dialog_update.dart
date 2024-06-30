import 'package:flutter/material.dart';
import 'package:fluttercrud/datasources/remote_wisata_datasource.dart';
import 'package:fluttercrud/models/requests/all_request_wisata_model.dart';
import 'package:fluttercrud/models/response/another_response_model.dart';
import 'package:fluttercrud/models/response/get_wisata_response_model.dart';

class WisataShowDialogUpdate extends StatefulWidget {
  final Wisata wisata;

  const WisataShowDialogUpdate({Key? key, required this.wisata})
      : super(key: key);

  @override
  _WisataShowDialogUpdateState createState() => _WisataShowDialogUpdateState();
}

class _WisataShowDialogUpdateState extends State<WisataShowDialogUpdate> {
  late TextEditingController _namaController;
  late TextEditingController _gambarController;
  late TextEditingController _jamLayananController;
  late TextEditingController _jamTutupController;
  late TextEditingController _alamatController;

  final WisataRemoteDatasource _datasource = WisataRemoteDatasource();

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.wisata.namaWisata);
    _gambarController = TextEditingController(text: widget.wisata.gambar);
    _jamLayananController =
        TextEditingController(text: widget.wisata.jamLayanan);
    _jamTutupController = TextEditingController(text: widget.wisata.jamTutup);
    _alamatController = TextEditingController(text: widget.wisata.alamat);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _gambarController.dispose();
    _jamLayananController.dispose();
    _jamTutupController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Wisata'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _namaController,
            decoration: InputDecoration(labelText: 'Nama Wisata'),
          ),
          TextField(
            controller: _alamatController,
            decoration: InputDecoration(labelText: 'Alamat'),
          ),
          TextField(
            controller: _gambarController,
            decoration: InputDecoration(labelText: 'Gambar'),
          ),
          TextField(
            controller: _jamLayananController,
            decoration: InputDecoration(labelText: 'Jam Layanan'),
          ),
          TextField(
            controller: _jamTutupController,
            decoration: InputDecoration(labelText: 'Jam Tutup'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Update'),
          onPressed: () async {
            String nama = _namaController.text;
            String alamat = _alamatController.text;
            String gambar = _gambarController.text;
            String jamLayanan = _jamLayananController.text;
            String jamTutup = _jamTutupController.text;

            // Create the request model
            AllRequestWisataModel updateModel = AllRequestWisataModel(
              id: int.parse(widget.wisata.id),
              nama_wisata: nama,
              alamat: alamat,
              gambar: gambar,
              jam_layanan: jamLayanan,
              jam_tutup: jamTutup,
            );

            try {
              // Perform update operation
              AnotherResponseModel response =
                  await _datasource.updateWisata(updateModel);
              if (response.status == 200) {
                print('Update successful: ${response.result}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Update successful: ${response.result}')),
                );
              } else {
                print('Update failed: ${response.result}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: ${response.result}')),
                );
              }
            } catch (e) {
              print('Update error: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Update error: $e')),
              );
            }

            // Close the dialog
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
