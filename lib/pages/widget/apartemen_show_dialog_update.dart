import 'package:flutter/material.dart';
import 'package:fluttercrud/models/response/get_apartemen_response_model.dart';
import 'package:fluttercrud/models/requests/all_request_model.dart';

import '../../datasources/remote_datasource.dart';
import '../../models/response/another_response_model.dart';

class ApartemenShowDialogUpdate extends StatefulWidget {
  final Result apartemen; // Terima data apartemen dari ApartemenUi

  const ApartemenShowDialogUpdate({Key? key, required this.apartemen})
      : super(key: key);

  @override
  _ApartemenShowDialogUpdateState createState() =>
      _ApartemenShowDialogUpdateState();
}

class _ApartemenShowDialogUpdateState extends State<ApartemenShowDialogUpdate> {
  late TextEditingController _controllerNama;
  late TextEditingController _controllerAlamat;
  late TextEditingController _controllerGambar;
  final ApartemenRemoteDatasource _datasource = ApartemenRemoteDatasource();

  @override
  void initState() {
    super.initState();
    _controllerNama =
        TextEditingController(text: widget.apartemen.namaApartemen);
    _controllerAlamat = TextEditingController(text: widget.apartemen.alamat);
    _controllerGambar = TextEditingController(text: widget.apartemen.gambar);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Apartemen'),
      content: Column(
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
            decoration: InputDecoration(labelText: 'Gambar'),
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
            String nama = _controllerNama.text;
            String alamat = _controllerAlamat.text;
            String gambar = _controllerGambar.text;

            // Create the request model
            AllRequestModel updateModel = AllRequestModel(
              id: int.parse(widget.apartemen.id),
              namaApartemen: nama,
              alamat: alamat,
              gambar: gambar,
            );

            try {
              // Perform update operation
              AnotherResponseModel response =
                  await _datasource.updateApartemen(updateModel);
              if (response.status == 200) {
                // Handle successful update if necessary
                print('Update successful: ${response.result}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Update successful: ${response.result}')),
                );
              } else {
                // Handle error
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
