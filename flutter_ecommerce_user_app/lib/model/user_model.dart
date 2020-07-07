import 'package:flutter/cupertino.dart';

class User {
  int userId;
  String userEmail;
  String userName;
  String userDOB;
  String password;
  String userType;
  String userNumber;
  String createdDateTime;

  User({
    this.userId,
    this.password,
    @required this.userNumber,
    @required this.userType,
    @required this.userName,
    @required this.userEmail,
    @required this.userDOB,
    this.createdDateTime,
  });
}
