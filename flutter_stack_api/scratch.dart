import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

var x;

main() async {
  print('start');

//  Isolate.spawn(demo1, {'name': 'Mashood', 'email': 'mashood@gmail.com'});
//  Isolate.spawn(demo1, {'name': 'Saad', 'email': 'Saad@gmail.com'});
//  Isolate.spawn(demo1, {'name': 'Saad', 'email': 'Saad@gmail.com'});
//  Isolate.spawn(demo1, {'name': 'Mashood', 'email': 'mashood@gmail.com'});

  var map = {'email': 'abwc@gmail.com', 'password': 'Password'};

  final x = await compute(signInUser, map);
  print(x);
  print('end');
}

Future signInUser(Map<String, String> signInMap) async {
  const String signIn = 'http://192.168.1.105:3000/adminAuth/signIn';
  var result = await http.post(signIn, headers: {
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
  }, body: {
    'userEmail': signInMap['email'],
    'userPassword': signInMap['password'],
  });
  print(signInMap['email']);
  print(json.decode(result.body));
  return json.decode(result.body) as Map<String, String>;
}

demo1(Map<String, String> map) {
  print('Hello ${map['name']}');
}
