import 'dart:convert';

class AnotherResponseModel {
    final int status;
    final String result;

    AnotherResponseModel({
        required this.status,
        required this.result,
    });

    factory AnotherResponseModel.fromRawJson(String str) => AnotherResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AnotherResponseModel.fromJson(Map<String, dynamic> json) => AnotherResponseModel(
        status: json["status"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": result,
    };
}
