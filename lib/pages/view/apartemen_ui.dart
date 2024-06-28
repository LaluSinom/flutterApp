import 'package:flutter/material.dart';
import 'package:fluttercrud/datasources/remote_datasource.dart';
import 'package:fluttercrud/models/requests/all_request_model.dart';
import 'package:fluttercrud/models/response/another_response_model.dart';
import 'package:fluttercrud/models/response/get_apartemen_response_model.dart';
import 'package:fluttercrud/pages/widget/apartemen_show_dialog_add.dart';
// import 'package:fluttercrud/widgets/apartemen_show_dialog_update.dart';

import '../widget/apartemen_show_dialog_update.dart';

class ApartemenUi extends StatefulWidget {
  const ApartemenUi({Key? key}) : super(key: key);

  @override
  _ApartemenUiState createState() => _ApartemenUiState();
}

class _ApartemenUiState extends State<ApartemenUi> {
  late Future<GetApartemenResponseModel> _futureApartemen;
  final ApartemenRemoteDatasource _datasource = ApartemenRemoteDatasource();

  @override
  void initState() {
    super.initState();
    _futureApartemen = _datasource.getApartemen();
  }

  void _showUpdateDialog(BuildContext context, Result apartemen) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ApartemenShowDialogUpdate(apartemen: apartemen);
      },
    );
  }

  void _showCreateDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ApartemenShowDialogAdd();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apartemen List'),
      ),
      body: FutureBuilder<GetApartemenResponseModel>(
        future: _futureApartemen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final response = snapshot.data!;
            return ListView.builder(
              itemCount: response.result.length,
              itemBuilder: (context, index) {
                final apartemen = response.result[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    leading: Image.network(
                      apartemen.gambar,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      apartemen.namaApartemen,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      apartemen.alamat,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showUpdateDialog(context,
                                apartemen); // Panggil fungsi _showUpdateDialog
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            AllRequestModel deleteModel = AllRequestModel(
                              id: int.parse(apartemen.id),
                              namaApartemen: apartemen.namaApartemen,
                              alamat: apartemen.alamat,
                              gambar: apartemen.gambar,
                            );

                            try {
                              AnotherResponseModel response =
                                  await ApartemenRemoteDatasource()
                                      .deleteApartemen(deleteModel);
                              if (response.status == 200) {
                                // Handle successful update if necessary
                                print('delete successful: ${response.result}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'delete successful: ${response.result}')),
                                );
                              } else {
                                // Handle error
                                print('delete failed: ${response.result}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'delete failed: ${response.result}')),
                                );
                              }
                            } catch (e) {
                              print('delete error: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('delete error: $e')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle tap on ListTile if needed
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateDialog(
              context); // Implement this method to show a dialog for creating a new apartment
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
