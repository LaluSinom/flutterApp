import 'package:flutter/material.dart';
import 'package:fluttercrud/datasources/remote_wisata_datasource.dart';
import 'package:fluttercrud/models/response/another_response_model.dart';

import '../../models/requests/all_request_wisata_model.dart';

class WisataShowDialogAdd extends StatefulWidget {
  const WisataShowDialogAdd({Key? key}) : super(key: key);

  @override
  _WisataShowDialogAddState createState() => _WisataShowDialogAddState();
}

class _WisataShowDialogAddState extends State<WisataShowDialogAdd> {

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _gambarController = TextEditingController();
  final TextEditingController _jamLayananController = TextEditingController();
  final TextEditingController _jamTutupController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final WisataRemoteDatasource _datasource = WisataRemoteDatasource();

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
      title: Text('Add New Wisata'),
      content: SingleChildScrollView(
        child: Column(
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
              decoration: InputDecoration(labelText: 'Gambar URL'),
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
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Add'),
          onPressed: () async {
            // Collect the data and close the dialog
            final String nama = _namaController.text;
            final String alamat = _alamatController.text;
            final String gambar = _gambarController.text;
            final String jamLayanan = _jamLayananController.text;
            final String jamTutup = _jamTutupController.text;

            if (nama.isNotEmpty && alamat.isNotEmpty && gambar.isNotEmpty && jamLayanan.isNotEmpty && jamTutup.isNotEmpty) {
              AllRequestWisataModel addWisataModel = AllRequestWisataModel(
                nama_wisata: nama,
                gambar: gambar,
                jam_layanan: jamLayanan,
                jam_tutup: jamTutup,
                alamat: alamat,
              );

              try {
                // Perform Add operation
                AnotherResponseModel response = await _datasource.addWisata(addWisataModel);
                if (response.status == 200) {
                  print('Add successful: ${response.result}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Add successful: ${response.result}'),
                    ),
                  );
                } else {
                  print('Add failed: ${response.result}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Add failed: ${response.result}'),
                    ),
                  );
                }
              } catch (e) {
                print('Add error: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Add error: $e')),
                );
              }

              // Close the dialog
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('All fields are required')),
              );
            }
          },
        ),
      ],
    );
  }
}
