import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class ApiService {
  static Future<Map<String, dynamic>?> get(String url,
      [Map<String, dynamic>? queryParams]) async {
    Uri uri = Uri.parse(url).replace(queryParameters: queryParams);
    try {
      final response = await http.get(uri, headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(response.body);
        return responseJson;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
