import 'package:flutter/material.dart';
import 'package:fluttercrud/datasources/remote_datasource.dart';

import '../../models/requests/all_request_model.dart';
import '../../models/response/another_response_model.dart';

class ApartemenShowDialogAdd extends StatefulWidget {
  const ApartemenShowDialogAdd({Key? key}) : super(key: key);

  @override
  _ApartemenShowDialogAddState createState() => _ApartemenShowDialogAddState();
}

class _ApartemenShowDialogAddState extends State<ApartemenShowDialogAdd> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerAlamat = TextEditingController();
  final TextEditingController _controllerGambar = TextEditingController();
  final ApartemenRemoteDatasource _datasource = ApartemenRemoteDatasource();

  @override
  void dispose() {
    _controllerNama.dispose();
    _controllerAlamat.dispose();
    _controllerGambar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Apartemen'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _controllerNama,
              decoration: InputDecoration(labelText: 'Nama Apartemen'),
            ),
            TextField(
              controller: _controllerAlamat,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              controller: _controllerGambar,
              decoration: InputDecoration(labelText: 'Gambar URL'),
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
            final String nama = _controllerNama.text;
            final String alamat = _controllerAlamat.text;
            final String gambar = _controllerGambar.text;
            if (nama.isNotEmpty && alamat.isNotEmpty && gambar.isNotEmpty) {
              AllRequestModel addModel = AllRequestModel(
                namaApartemen: nama,
                alamat: alamat,
                gambar: gambar,
              );

              try {
                // Perform Add operation
                AnotherResponseModel response =
                    await _datasource.addApartemen(addModel);
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
