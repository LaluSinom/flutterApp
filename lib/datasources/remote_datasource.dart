import 'package:fluttercrud/models/requests/all_request_model.dart';
import 'package:fluttercrud/models/response/another_response_model.dart';
import 'package:fluttercrud/models/response/get_apartemen_response_model.dart';
import 'package:http/http.dart' as http;

class ApartemenRemoteDatasource {
  Future<GetApartemenResponseModel> getApartemen() async {
    final url = Uri.parse(
        "http://localhost//be-mobile/apartemen/getApartemen.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return GetApartemenResponseModel.fromRawJson(response.body);
    } else {
      throw Exception(
          "Failed to load apartemen. Status code: ${response.statusCode}");
    }
  }

  Future<AnotherResponseModel> addApartemen(AllRequestModel model) async {
    final url =
        Uri.parse("http://localhost/be-mobile/apartemen/createApartemen.php");
    final response = await http.post(url,
        body: model.toRawJson(), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception(
          "Failed to add apartemen. Status code: ${response.statusCode}");
    }
  }

  Future<AnotherResponseModel> updateApartemen(AllRequestModel model) async {
    final url = Uri.parse(
        "http://localhost/be-mobile/apartemen/updateApartemen.php");
    final response = await http.post(url,
        body: model.toRawJson(), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception("Failed");
    }
  }

  Future<AnotherResponseModel> deleteApartemen(AllRequestModel model) async {
    final url = Uri.parse(
        "http://localhost/be-mobile/apartemen/deleteApartemen.php");
    final response = await http.post(url,
        body: model.toRawJson(), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return AnotherResponseModel.fromRawJson(response.body);
    } else {
      throw Exception(
          "Failed to delete apartemen. Status code: ${response.statusCode}");
    }
  }
}
