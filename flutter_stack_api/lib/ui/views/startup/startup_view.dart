import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/startup/startup_viewmodel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatefulWidget {
  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model)async =>await model.getPermissionStatus(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
