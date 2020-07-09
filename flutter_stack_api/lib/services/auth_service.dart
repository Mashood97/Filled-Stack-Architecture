import 'dart:convert';

import 'package:flutterstackapi/helpers/common_api.dart';
import 'package:flutterstackapi/helpers/http_exception.dart';
import 'package:flutterstackapi/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  DateTime dateTime = DateTime.now();

  String _userId;
  String _userName;
  String _userEmail;
  String _userNumber;
  String _userDOB;
  String _userType = 'admin';

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

  Future signUpAdmin(String name, String email, String password,
      String phonenumber, String dob) async {
    try {
      final response = await http.post(CommonAPI.signupUrl, headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'userEmail': email,
        'userPassword': password,
        'userName': name,
        'userNumber': phonenumber,
        'userDOB': dob,
        'userType': 'admin',
        'createdDateTime': dateTime.toString(),
      });
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      return responseData;
    } catch (e) {
      throw e.message;
    }
  }

  Future signInAdmin(String email, String password) async {
    try {
      final response = await http.post(CommonAPI.signInUrl, headers: {
        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
      }, body: {
        'userEmail': email,
        'userPassword': password
      });
//      String getPassword = _secureStorage.encrypt(password);

      final responseData = json.decode(response.body) as Map<String, dynamic>;
      return responseData;
    } catch (e) {
      throw e.message;
    }
  }

//      final message = responseData['data']['message'];
//      final getuserData = responseData['data']['userData'];
//      print(message);
//      if (message == 'Success') {
//        _userId = getuserData['userId'].toString();
//        _userType = getuserData['userType'];
//        _userName = getuserData['UserName'];
//        _userDOB = getuserData['userDOB'];
//        _userNumber = getuserData['userNumber'];
//        _userEmail = getuserData['userEmail'];
//      } else {
//        throw HttpException(message);
//      }
//
//      final authData = json.encode({
//        "userId": _userId,
//        "userEmail": _userEmail,
//        "userName": _userName,
//        "userNumber": _userNumber,
//        "userDOB": _userDOB,
//        "userType": _userType,
//      });
//      await SharedPref.init();
//      SharedPref.setAuthdata(authData);

//  Future<bool> autoLogin() async {
//    return _userId != null;
//  }

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

    _userId = extractedData['userId'];
    _userName = extractedData['userName'];
    _userEmail = extractedData['userEmail'];
    _userNumber = extractedData['userNumber'];
    _userDOB = extractedData['userDOB'];
    _userType = extractedData['userType'];

    return true;
  }

//
    Future logoutUser() async {
      await SharedPref.init();
      SharedPref.clearSharedPrefData();
      _userId = null;
      _userName = null;
      _userEmail = null;
      _userNumber = null;
      _userDOB = null;
      _userType = null;
      dateTime = null;
      return true;
    }
}
