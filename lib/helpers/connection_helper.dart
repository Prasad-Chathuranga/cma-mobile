import 'dart:convert';

import 'package:cma_mobile/helpers/data_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

class ConnectionHelper {
  final httpClient = http.Client();
  final BuildContext buildContext;
  bool _useToken = false;
  late DataHelper dataProvider;
  http.BaseRequest? _request;

  ConnectionHelper(this.buildContext) {
    dataProvider = Provider.of<DataHelper>(buildContext, listen: false);
  }

  ///Send the HTTP Request
  ///
  Future<http.StreamedResponse>? send() {
    if (_useToken) {
      _request!.headers['Authorization'] = 'Bearer ${dataProvider.getToken()}';
      // print(_request!.headers['Authorization']);
    }

    _request!.headers['Flair-Device'] = dataProvider.getDeviceId();
    _request!.headers['Accept'] = 'application/json';

    try {
      return httpClient.send(_request!);
    } on Exception catch (_) {
      return null;
    }
  }

  Future<CMAResponse>? sendAndMap() {
    try {
      return CMAResponse.fromResponse(send());
    } catch (e) {
      return null;
    }
  }

  ///Creates a http request;
  T createRequest<T>(String method, String path,
      {Map<String, String>? queryParams}) {
    _request = http.Request(
        method,
        Uri.http(DataHelper.apiEndPoint, "${DataHelper.apiPath}/$path",
            queryParams));

    return this as T;
  }

  /// Add data to the request
  ConnectionHelper withFields(Map<String, String> fields) {
    (_request as http.Request).bodyFields = fields;
    return this;
  }

  /// Send the information with  a token
  ConnectionHelper withToken() {
    _useToken = true;
    return this;
  }
}

//Multipart connnection helper
class MultipartConnectionHelper extends ConnectionHelper {
  MultipartConnectionHelper(super.buildContext);

  ///Creates a http request;
  @override
  T createRequest<T>(String method, String path,
      {Map<String, String>? queryParams}) {
    _request = http.MultipartRequest(
        method,
        Uri.http(DataHelper.apiEndPoint, "${DataHelper.apiPath}/$path",
            queryParams));

    return this as T;
  }

  @override
  ConnectionHelper withFields(Map<String, String> fields) {
    return this;
  }

  MultipartConnectionHelper addField(String param, String value) {
    (_request as http.MultipartRequest).fields[param] = value;
    return this;
  }

  MultipartConnectionHelper addFile(
      String param, List<int> value, String filename, MediaType contentType) {
    (_request as http.MultipartRequest).files.add(http.MultipartFile.fromBytes(
        param, value,
        filename: filename, contentType: contentType));
    return this;
  }
}
//Multipart connnection helper

/// Class for accessing response information easily
class CMAResponse {
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
  CMAResponse(String? stream, int responseCode) {
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
  static Future<CMAResponse> fromResponse(
      Future<http.StreamedResponse>? res) async {
    if (res == null) {
      return CMAResponse(null, 0);
    }

    late http.StreamedResponse fRes;
    try {
      fRes = await res;
    } on Exception catch (_) {
      return CMAResponse(null, 0);
    }

    if (fRes.headers['content-type'] != 'application/json') {
      return CMAResponse(null, 0);
    }

    var finalString = await fRes.stream.bytesToString();

    var inst = CMAResponse(finalString, fRes.statusCode);
    inst.response = fRes;

    return inst;
  }
} //CMAResponse
