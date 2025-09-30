import 'dart:convert';
import 'dart:io';

import 'package:anjuman_committee/data/network/base_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet connection');
    } on RequestTimeoutException {
      throw RequestTimeoutException('Connection timeout');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print('URL: $url');
      print('DATA: $data');
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              "Content-Type": "application/json", // 👈 Important
            },
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet connection');
    } on RequestTimeoutException {
      throw RequestTimeoutException('Connection timeout');
    } on ServerException {
      throw ServerException('Invalid server response.');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        return jsonDecode(response.body);
      default:
        throw FetchDataException(
          'Error occurred while communicating with server${response.statusCode}',
        );
    }
  }
}
