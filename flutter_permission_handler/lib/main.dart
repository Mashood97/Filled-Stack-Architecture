import 'package:flutter/material.dart';
import 'package:flutterpermissionhandler/screen2.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PermissionHandlerHomePage(),
    );
  }
}

class PermissionHandlerHomePage extends StatefulWidget {
  @override
  _PermissionHandlerHomePageState createState() =>
      _PermissionHandlerHomePageState();
}

class _PermissionHandlerHomePageState extends State<PermissionHandlerHomePage> {
  final PermissionHandler _permissionHandler = PermissionHandler();

//  @override
//  void initState() {
//    super.initState();
//    permissionHandle();
//  }

  void getPermissionStatus() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission == PermissionStatus.granted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => Screen2()));
    } // ideally you should specify another condition if permissions is denied
    else if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.neverAskAgain ||
        permission == PermissionStatus.restricted) {
      await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
      getPermissionStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    getPermissionStatus();
    return Scaffold();
  }
}
