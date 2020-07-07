import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/model/user_model.dart';
import 'package:flutterecommerceuserapp/ui/views/signup/signup_viewmodel.dart';
import 'package:flutterecommerceuserapp/ui/widgets/major_text_field.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _userDOBController = TextEditingController();
  final _userNumberController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _numberFocusNode = FocusNode();
  final _DOBFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _DOBFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _userDOBController.dispose();
    _userNumberController.dispose();
    _passwordFocusNode.dispose();
    _numberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (ctx, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/6.png',
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    'Sign-Up!',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontSize: 24,
                        ),
                  ),
                  MajorTextField(
                    icon: Icons.person_pin,
                    inputType: TextInputType.text,
                    maxLength: 50,
                    inputAction: TextInputAction.next,
                    controller: _userNameController,
                    titleLabel: 'Enter Your Name',
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Name.';
                      }
                      return null;
                    },
                  ),
                  MajorTextField(
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    maxLength: 50,
                    focusnode: _emailFocusNode,
                    inputAction: TextInputAction.next,
                    controller: _emailController,
                    titleLabel: 'Enter Your E-mail',
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter E-mail';
                      }
                      return null;
                    },
                  ),
                  MajorTextField(
                    icon: Icons.phonelink_lock,
                    inputType: TextInputType.text,
                    maxLength: 50,
                    focusnode: _passwordFocusNode,
                    inputAction: TextInputAction.next,
                    controller: _passwordController,
                    titleLabel: 'Enter Your password',
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_numberFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Password.';
                      }
                      return null;
                    },
                  ),
                  MajorTextField(
                    icon: Icons.phone_iphone,
                    inputType: TextInputType.number,
                    maxLength: 50,
                    inputAction: TextInputAction.next,
                    controller: _userNumberController,
                    focusnode: _numberFocusNode,
                    titleLabel: 'Enter Your Number',
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_DOBFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Number.';
                      }
                      return null;
                    },
                  ),
                  MajorTextField(
                    icon: Icons.calendar_today,
                    inputType: TextInputType.text,
                    maxLength: 50,
                    focusnode: _DOBFocusNode,
                    inputAction: TextInputAction.done,
                    controller: _userDOBController,
                    titleLabel: 'Enter Your Date of birth',
                    maxLines: 1,
                    fieldSubmit: (_) {
//                      FocusScope.of(context)
//                          .requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Date of birth.';
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
                          model.signUpUser(
                            User(
                              userEmail: _emailController.text.toString(),
                              userName: _userNameController.text.toString(),
                              userNumber: _userNumberController.text.toString(),
                              userType: 'user',
                              userDOB: _userDOBController.text.toString(),
                              password: _passwordController.text.toString(),
                            ),
                          );
                        },
                        child: Text(
                          'Register',
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
                        'Login Now',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        model.navigateToLogin();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
