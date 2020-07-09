import 'dart:convert';

import 'package:flutterecommerceuserapp/helpers/common_api.dart';
import 'package:flutterecommerceuserapp/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutterecommerceuserapp/helpers/shared_preferences.dart';

class AuthService {
  String _datetime = DateTime.now().toString();

  String _userId;
  String _userName;
  String _userEmail;
  String _userNumber;
  String _userDOB;
  String _userType = 'user';

  bool get getAuthLogin => _userId != null;

  void setUserId(String userid) {
    _userId = userid;
  }

  String get getuserId => _userId;

  void setUserName(String name) {
    _userName = name;
  }

  String get getusername => _userName;

  void setUserEmail(String email) {
    _userEmail = email;
  }

  String get getEmail => _userEmail;

  void setuserNumber(String number) {
    _userNumber = number;
  }

  String get getNumber => _userNumber;

  void setUserDOB(String DOB) {
    _userDOB = DOB;
  }

  String get getUserDOB => _userDOB;

  void setUserType(String userType) {
    _userType = userType;
  }

  String get getUserType => _userType;

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

  Future signUpUser(User user) async {
    try {
      final response = await http.post(CommonAPi.signUpUrl, headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'userEmail': user.userEmail,
        'userPassword': user.password,
        'userName': user.userName,
        'userNumber': user.userNumber,
        'userDOB': user.userDOB,
        'userType': user.userType,
        'createdDateTime': _datetime,
      });
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('RESPONSE DATA ======= $responseData');
      return responseData;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> autoLogin() async {
    await SharedPref.init();
    String abc = SharedPref.getAuthData();
    // if (abc == null || abc.isEmpty) {
    //   return false;
    // }
    final extractedData = json.decode(abc) as Map<String, Object>;
    if (extractedData == null || extractedData.isEmpty) {
      return false;
    }

    _userId = extractedData['userId'].toString();
    _userName = extractedData['userName'];
    _userEmail = extractedData['userEmail'];
    _userNumber = extractedData['userNumber'];
    _userDOB = extractedData['userDOB'];
    _userType = extractedData['userType'];

    return true;
  }

  Future logoutUser() async {
    await SharedPref.init();
    SharedPref.clearSharedPrefData();
    _userId = null;
    _userName = null;
    _userEmail = null;
    _userNumber = null;
    _userDOB = null;
    _userType = null;
    _datetime = null;
    return true;
  }
}
