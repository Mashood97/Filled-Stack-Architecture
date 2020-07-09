import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/model/user_model.dart';
import 'package:flutterecommerceuserapp/ui/views/signup/signup_viewmodel.dart';
import 'package:flutterecommerceuserapp/ui/widgets/android_text_field.dart';
import 'package:flutterecommerceuserapp/ui/widgets/ios_text_field.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
  DateTime _selectedDate;

  void showDatePickerDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1800),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void showIOSDatePickerDialog() {
    CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      initialDateTime: DateTime.now(),
//      minimumDate: DateTime(1800),
//      maximumDate: DateTime.now(),
      onDateTimeChanged: (dt) {
        if (dt == null) {
          return;
        }
        setState(() {
          _selectedDate = dt;
        });
      },
    );
  }

  Widget getDatePickerLayout(var _date, Function onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _date == null
                ? 'No Date Selected'
                : DateFormat.yMMMEd().format(_date).toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            splashColor: Theme.of(context).primaryColor,
            child: Text(
              'Pick Date',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }

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

  Widget _getAndroidDesign(var model) {
    return Scaffold(
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
                getDatePickerLayout(_selectedDate, showDatePickerDialog),

//                MajorTextField(
//                  icon: Icons.calendar_today,
//                  inputType: TextInputType.text,
//                  maxLength: 50,
//                  focusnode: _DOBFocusNode,
//                  inputAction: TextInputAction.done,
//                  controller: _userDOBController,
//                  titleLabel: 'Enter Your Date of birth',
//                  maxLines: 1,
//                  fieldSubmit: (_) {
////                      FocusScope.of(context)
////                          .requestFocus(_passwordFocusNode);
//                  },
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please Enter Date of birth.';
//                    }
//                    return null;
//                  },
//                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      splashColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).accentColor,
                      onPressed: () async {
                        await model.signUpUser(
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
    );
  }

  Widget _getIOSDesign(var model) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
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
                  IOSTextField(
                    controller: _userNameController,
                    inputType: TextInputType.text,
                    maxLength: 30,
                    inputAction: TextInputAction.next,
                    titleLabel: 'Enter your name',
                    iconData: CupertinoIcons.person_solid,
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                  IOSTextField(
                    controller: _emailController,
                    focusnode: _emailFocusNode,
                    inputType: TextInputType.emailAddress,
                    maxLength: 30,
                    inputAction: TextInputAction.next,
                    titleLabel: 'Enter your E-mail',
                    iconData: CupertinoIcons.mail_solid,
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  IOSTextField(
                    controller: _passwordController,
                    focusnode: _passwordFocusNode,
                    inputType: TextInputType.text,
                    obsecureText: true,
                    maxLength: 30,
                    inputAction: TextInputAction.next,
                    titleLabel: 'Enter your Password',
                    iconData: CupertinoIcons.padlock_solid,
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_numberFocusNode);
                    },
                  ),
                  IOSTextField(
                    controller: _userNumberController,
                    focusnode: _numberFocusNode,
                    inputType: TextInputType.number,
                    maxLength: 30,
                    inputAction: TextInputAction.done,
                    titleLabel: 'Enter your Phone Number',
                    iconData: CupertinoIcons.phone_solid,
                    maxLines: 1,
                    fieldSubmit: (_) {
                      FocusScope.of(context).requestFocus(_DOBFocusNode);
                    },
                  ),

                  getDatePickerLayout(_selectedDate, showIOSDatePickerDialog),
//                IOSTextField(
//                  controller: _userDOBController,
//                  focusnode: _DOBFocusNode,
//                  inputType: TextInputType.text,
//                  maxLength: 30,
//                  inputAction: TextInputAction.next,
//                  titleLabel: 'Enter your date of birth',
//                  iconData: CupertinoIcons.news_solid,
//                  maxLines: 1,
//                ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _selectedDate.toString().isNotEmpty &&
                              _userNameController.text.isNotEmpty &&
                              _userNumberController.text.isNotEmpty) {
                            await model.signUpUser(
                              User(
                                userEmail: _emailController.text.toString(),
                                userName: _userNameController.text.toString(),
                                userNumber:
                                    _userNumberController.text.toString(),
                                userType: 'user',
                                userDOB: _selectedDate.toString(),
                                password: _passwordController.text.toString(),
                              ),
                            );
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (ctx, model, child) =>
          Platform.isIOS ? _getIOSDesign(model) : _getAndroidDesign(model),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
