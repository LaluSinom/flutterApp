import 'package:flutter/material.dart';
import 'package:fluttercrud/datasources/remote_wisata_datasource.dart';
import 'package:fluttercrud/models/requests/all_request_wisata_model.dart';
import 'package:fluttercrud/models/response/get_wisata_response_model.dart';
import 'package:fluttercrud/pages/view/detail_wisata.dart';
import 'package:fluttercrud/pages/widget/wisata_show_dialog_update.dart';
import 'package:fluttercrud/pages/widget/wisata_show_dialog_add.dart';

class WisataUi extends StatefulWidget {
  const WisataUi({Key? key}) : super(key: key);

  @override
  _WisataUiState createState() => _WisataUiState();
}

class _WisataUiState extends State<WisataUi> {
  late Future<GetWisataResponseModel> _futureWisata;
  final WisataRemoteDatasource _datasource = WisataRemoteDatasource();

  @override
  void initState() {
    super.initState();
    _futureWisata = _datasource.getWisata();
  }

  void _showUpdateDialog(BuildContext context, Wisata wisata) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WisataShowDialogUpdate(wisata: wisata);
      },
    );
  }

  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WisataShowDialogAdd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wisata List'),
      ),
      body: FutureBuilder<GetWisataResponseModel>(
        future: _futureWisata,
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
                final wisata = response.result[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    leading: Image.network(
                      wisata.gambar,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      wisata.namaWisata,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      wisata.alamat,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showUpdateDialog(context, wisata);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            AllRequestWisataModel deleteWisataModel =
                                AllRequestWisataModel(
                              id: int.parse(wisata.id),
                              nama_wisata: wisata.namaWisata,
                              alamat: wisata.alamat,
                              gambar: wisata.gambar,
                              jam_layanan: wisata.jamLayanan,
                              jam_tutup: wisata.jamTutup,
                            );

                            try {
                              final response = await _datasource
                                  .deleteWisata(deleteWisataModel);
                              if (response.status == 200) {
                                print('Delete successful: ${response.result}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Delete successful: ${response.result}')),
                                );
                                setState(() {
                                  _futureWisata = _datasource.getWisata();
                                });
                              } else {
                                print('Delete failed: ${response.result}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Delete failed: ${response.result}')),
                                );
                              }
                            } catch (e) {
                              print('Delete error: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Delete error: $e')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailWisata(wisata: wisata)),
                      );
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
          _showCreateDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
