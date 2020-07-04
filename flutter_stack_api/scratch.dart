import 'dart:async';
import 'dart:isolate';
import 'package:http/http.dart' as http;

main() {
  print('start');
//  Isolate.spawn(demo1, {'name': 'Mashood', 'email': 'mashood@gmail.com'});
//  Isolate.spawn(demo1, {'name': 'Saad', 'email': 'Saad@gmail.com'});
//  Isolate.spawn(demo1, {'name': 'Saad', 'email': 'Saad@gmail.com'});
//  Isolate.spawn(demo1, {'name': 'Mashood', 'email': 'mashood@gmail.com'});



  Timer(
    Duration(milliseconds: 100),
      ()=>Isolate.spawn(signInUser, {'email': 'mashood@gmail.com','password':'Sodium97'}));
  Isolate.spawn(signInUser, {'email': 'mashood@gmail.com','password':'Sodium97'});

      print('end');
}

demo1(Map<String, String> map) {
  print('Hello ${map['name']}');
}

signInUser(Map<String, dynamic> signInMap) async {
  const String signIn = 'http://192.168.1.105:3000/adminAuth/signIn';
  var result = await http.post(signIn, headers: {
    "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
  }, body: {
    'userEmail': signInMap['email'],
    'userPassword': signInMap['password'],
  });
  print(signInMap['email']);
  print(result);
}
