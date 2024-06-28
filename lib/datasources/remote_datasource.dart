
import 'package:fluttercrud/models/requests/all_request_model.dart';
import 'package:fluttercrud/models/response/another_response_model.dart';
import 'package:fluttercrud/models/response/get_apartemen_response_model.dart';
import 'package:http/http.dart' as http;

class ApartemenRemoteDatasource {
  Future<GetApartemenResponseModel> getApartemen() async {
    final url = Uri.parse("http://192.168.234.1/mobile_lanjut/apartemen/getApartemen.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GetApartemenResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load apartemen. Status code: ${response.statusCode}");
    }
  }

  Future<AnotherResponseModel> addApartemen(AllRequestModel model) async {
    final url = Uri.parse("http://localhost/mobile_lanjut/apartemen/addApartemen.php");
    final response = await http.post(url, body: model.toRawJson(), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to add apartemen. Status code: ${response.statusCode}");
    }
  }

  Future<String> fetchData() async {
    final url = Uri.parse("http://localhost/mobile_lanjut/apartemen/getApartemen.php");
    try {
      final response = await http.get(url);
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to connect to server.');
    }
  }

  Future<AnotherResponseModel> deleteApartemen(AllRequestModel model) async {
    final url = Uri.parse("http://localhost/mobile_lanjut/apartemen/deleteApartemen.php");
    final response = await http.post(url, body: model.toRawJson(), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed to delete apartemen. Status code: ${response.statusCode}");
    }
  }
}
