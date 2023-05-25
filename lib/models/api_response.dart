import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiResponse {
  http.StreamedResponse? response;

  ///Response received
  bool _ok = false;

  ///Response code
  int? _responseCode;

  ///Data map
  Map<String, dynamic>? _responseData;

  ///Get response code
  int get responseCode {
    return _responseCode ?? 0;
  }

  /// Response data
  Map<String, dynamic>? get data {
    return _responseData;
  }

  bool get isOk => _ok;

  /// Get the server message
  String? get message {
    return (_responseData != null && _responseData!.containsKey('message'))
        ? (_responseData!["message"].toString().isEmpty
            ? "$responseCode : ${response!.reasonPhrase}"
            : _responseData!["message"])
        : null;
  }

  ///Constructor
  ApiResponse(String? stream, int responseCode) {
    if (stream == null) {
      return;
    }
    try {
      _responseData = jsonDecode(stream) as Map<String, dynamic>?;
      _responseCode = responseCode;
      _ok = true;
    } catch (_) {}
  }

  ///Form an instance from a response
  static Future<ApiResponse> fromResponse(
      Future<http.StreamedResponse>? res) async {
    if (res == null) {
      return ApiResponse(null, 0);
    }

    late http.StreamedResponse fRes;
    try {
      fRes = await res;
    } on Exception catch (_) {
      return ApiResponse(null, 0);
    }

    if (fRes.headers['content-type'] != 'application/json') {
      return ApiResponse(null, 0);
    }

    var finalString = await fRes.stream.bytesToString();

    var inst = ApiResponse(finalString, fRes.statusCode);
    inst.response = fRes;

    return inst;
  }
}
