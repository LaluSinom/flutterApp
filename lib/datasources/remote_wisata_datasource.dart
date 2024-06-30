import 'package:fluttercrud/models/requests/all_request_wisata_model.dart';
import 'package:fluttercrud/models/response/another_response_model.dart';
import 'package:fluttercrud/models/response/get_wisata_response_model.dart';
import 'package:http/http.dart' as http;

class WisataRemoteDatasource {
  Future<GetWisataResponseModel> getWisata() async {
    final url = Uri.parse("http://localhost/be-mobile/wisata/getWisata.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GetWisataResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load Wisata. Status code: ${response.statusCode}");
    }
  }

  Future<AnotherResponseModel> addWisata(AllRequestWisataModel model) async {
    final url = Uri.parse("http://localhost/be-mobile/wisata/createWisata.php");
    final response = await http.post(url,
      body: model.toRawJson(),
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to add Wisata. Status code: ${response.statusCode}");
    }
  }

  Future<AnotherResponseModel> updateWisata(AllRequestWisataModel model) async {
    final url = Uri.parse("http://localhost/be-mobile/wisata/updateWisata.php");
    final response = await http.post(url,
      body: model.toRawJson(), 
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to update Wisata. Status code: ${response.statusCode}");
    }
  }

  Future<AnotherResponseModel> deleteWisata(AllRequestWisataModel model) async {
    final url = Uri.parse("http://localhost/be-mobile/wisata/deleteWisata.php");
    final response = await http.post(url,
      body: model.toRawJson(), 
      headers: {'Content-Type': 'application/json'}
    );

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to delete Wisata. Status code: ${response.statusCode}");
    }
  }
}
