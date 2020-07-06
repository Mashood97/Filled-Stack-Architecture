import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/signin/signin_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (ctx, child, model) => Scaffold(
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                           Image.asset(
                            'assets/images/3.png',
                            height: 200,
                          ),

                        Text(
                          'Welcome Back!',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: 24,
                              ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => SignInViewModel());
  }
}


