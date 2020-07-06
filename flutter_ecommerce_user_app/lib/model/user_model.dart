import 'package:flutter/cupertino.dart';

class User {
  int userId;
  String userEmail;
  String userName;
  String userDOB;
  String userType;
  String createdDateTime;

  User({
    this.userId,
    @required this.userType,
    @required this.userName,
    @required this.userEmail,
    @required this.userDOB,
    @required this.createdDateTime,
  });
}
