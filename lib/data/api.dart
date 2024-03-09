import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://flutter-amr.noviindus.in/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    log("message");
    final url = Uri.parse('$baseUrl/Login');
    final response = await http.post(
      url,
      body: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // final token = responseData['token'];
      log(responseData.toString());
      return responseData;
    } else {
      log("Failed");
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }

  Stream<Map<String, dynamic>> fetchDataAsStream(String token) async* {
    final url = Uri.parse('https://flutter-amr.noviindus.in/api/BranchList');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      log("get");
      final Map<String, dynamic> responseData = json.decode(response.body);
      yield responseData;
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  }
}
