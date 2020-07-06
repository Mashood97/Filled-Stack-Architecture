import 'package:flutterstackapi/helpers/common_api.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../helpers/common_api.dart';

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

  Future deleteUserById(int userId) async {
    try {
      final response = await http.delete('${CommonAPI.deleteUser}/$userId');
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      return responseData;
    } catch (e) {
      throw e;
    }
  }
}
