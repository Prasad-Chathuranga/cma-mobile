import 'dart:convert';

import 'package:cma_mobile/constants.dart';
import 'package:cma_mobile/models/api_response.dart';
import 'package:http/http.dart' as http;

// Future<ApiResponse> login(String code, String password) async {

//   try {
//     var response = await http.post(Uri.parse(loginURL),
//         headers: {'Accept': 'application/json'},
//         body: {'code': code, 'password': password});

//     print(response);

//   } catch (e) {
//     // apiResponse.error = e.toString();
//   }

//   return apiResponse;
// }
