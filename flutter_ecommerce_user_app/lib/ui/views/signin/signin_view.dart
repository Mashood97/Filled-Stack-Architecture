import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/signin/signin_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (ctx, child, model) => Scaffold(

        ),
        viewModelBuilder: () => SignInViewModel());
  }
}
