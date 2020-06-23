import 'package:flutter/material.dart';
import 'package:fluttercalculatorstackarchi/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (ctx, model, child) => Scaffold(
        body: Center(
          child: RaisedButton(
            onPressed: () => model.navigateToHome(),
          ),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
