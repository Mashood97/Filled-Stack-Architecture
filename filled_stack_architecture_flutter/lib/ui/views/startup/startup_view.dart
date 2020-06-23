import 'package:filled_stack_architecture_flutter/ui/views/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Startup View Model'),
              RaisedButton(
                onPressed: () => model.navigateToHome(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
