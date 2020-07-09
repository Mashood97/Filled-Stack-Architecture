import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/ui/views/signin/signin_viewmodel.dart';
import 'package:flutterecommerceuserapp/ui/widgets/android_text_field.dart';
import 'package:flutterecommerceuserapp/ui/widgets/ios_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _key = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _getAndroidDesign(var model) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  MajorTextField(
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    maxLength: 50,
                    inputAction: TextInputAction.next,
                    controller: _emailController,
                    titleLabel: 'Enter Your E-mail',
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter E-mail.';
                      }
                      return null;
                    },
                  ),
                  MajorTextField(
                    icon: Icons.phonelink_lock,
                    inputType: TextInputType.text,
                    maxLength: 30,
                    obsecureText: true,
                    focusnode: _passwordFocusNode,
                    inputAction: TextInputAction.done,
                    titleLabel: 'Enter Your Password',
                    controller: _passwordController,
                    maxLines: 1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Password.';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        splashColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          model.signInUser(_emailController.text.toString(),
                              _passwordController.text.toString());
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      color: Colors.white,
                      shape: StadiumBorder(),
                      hoverColor: Theme.of(context).primaryColor,
                      splashColor: Theme.of(context).accentColor,
                      child: Text(
                        'Register Now',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        model.navigateToSignup();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getIosDesign(var model) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  IOSTextField(
                    titleLabel: 'Enter Your E-mail',
                    inputAction: TextInputAction.next,
                    maxLength: 50,
                    maxLines: 1,
                    inputType: TextInputType.emailAddress,
                    controller: _emailController,
                    iconData: CupertinoIcons.mail_solid,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  IOSTextField(
                    titleLabel: 'Enter Your Password',
                    inputAction: TextInputAction.done,
                    maxLines: 1,
                    maxLength: 8,
                    focusnode: _passwordFocusNode,
                    iconData: CupertinoIcons.padlock_solid,
                    inputType: TextInputType.text,
                    obsecureText: true,
                    controller: _passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            await model.signInUser(
                                _emailController.text.toString(),
                                _passwordController.text.toString());
                          } else {
                            model.showDialog(
                              'ERROR!',
                              'Auth Failed',
                              'OK',
                              DialogPlatform.Cupertino,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      color: Colors.white,
                      shape: StadiumBorder(),
                      hoverColor: Theme.of(context).primaryColor,
                      splashColor: Theme.of(context).accentColor,
                      child: Text(
                        'Register Now',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        model.navigateToSignup();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (ctx, model, child) =>
            Platform.isIOS ? _getIosDesign(model) : _getAndroidDesign(model),
        viewModelBuilder: () => SignInViewModel());
  }
}
