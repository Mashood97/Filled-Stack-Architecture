import 'dart:convert';

import 'package:flutterecommerceuserapp/helpers/common_api.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future signInUser(String email, password) async {
    try {
      final response = await http.post(
        CommonAPi.signInUrl,
        headers: {
          "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        },
        body: {'userEmail': email, 'userPassword': password},
      );
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      return responseData;
    } catch (e) {
      throw e;
    }
  }
}
