import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/signup/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (ctx, model, child) => Scaffold(),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
