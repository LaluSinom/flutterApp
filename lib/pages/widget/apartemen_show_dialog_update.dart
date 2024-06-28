import 'package:flutter/material.dart';
// import 'package:fluttercrud/models/response/another_response_model.dart';
import 'package:fluttercrud/models/response/get_apartemen_response_model.dart';

class ApartemenShowDialogUpdate extends StatefulWidget {
  final Result apartemen; // Terima data apartemen dari ApartemenUi

  const ApartemenShowDialogUpdate({Key? key, required this.apartemen}) : super(key: key);

  @override
  _ApartemenShowDialogUpdateState createState() => _ApartemenShowDialogUpdateState();
}

class _ApartemenShowDialogUpdateState extends State<ApartemenShowDialogUpdate> {
  late TextEditingController _controllerNama;
  late TextEditingController _controllerAlamat;

  @override
  void initState() {
    super.initState();
    _controllerNama = TextEditingController(text: widget.apartemen.namaApartemen);
    _controllerAlamat = TextEditingController(text: widget.apartemen.alamat);
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
          onPressed: () {
            // Handle update logic here
            String nama = _controllerNama.text;
            String alamat = _controllerAlamat.text;

            // Perform update operation with nama and alamat variables

            // Close the dialog
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
