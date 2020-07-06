import 'package:flutterstackapi/helpers/common_api.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {


  Future getAllUsers() async {
    try {
      final response = await http.get(CommonAPI.getAllusers);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      return responseData;
    } catch (e) {
      throw e;
    }
  }
}
