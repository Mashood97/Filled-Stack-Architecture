import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/signup/signup_viewmodel.dart';
import 'package:flutterstackapi/widgets/major_text_field.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();

  final userEmailController = TextEditingController();

  final userNumberController = TextEditingController();

  final userDOBController = TextEditingController();

  final userPasswordController = TextEditingController();

  final emailFocusNode = FocusNode();

  final PasswordFocusNode = FocusNode();

  final DOBFocusNode = FocusNode();

  final userNumberFocusNode = FocusNode();

  var _isLoading = false;

  Widget _getCardFields(var model) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SignUp with Us',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          MajorTextField(
            icon: Icons.input,
            inputType: TextInputType.text,
            maxLength: 50,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Name.';
              }
              return null;
            },
            inputAction: TextInputAction.next,
            titleLabel: 'Enter Your Name',
            fieldSubmit: (_) {
              FocusScope.of(context).requestFocus(emailFocusNode);
            },
            controller: userNameController,
          ),
          MajorTextField(
            icon: Icons.email,
            inputType: TextInputType.emailAddress,
            maxLength: 50,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Email Address.';
              }
              return null;
            },
            inputAction: TextInputAction.next,
            titleLabel: 'Enter Email Address',
            focusnode: emailFocusNode,
            fieldSubmit: (_) {
              FocusScope.of(context).requestFocus(userNumberFocusNode);
            },
            controller: userEmailController,
          ),
          MajorTextField(
            icon: Icons.phone_android,
            inputType: TextInputType.number,
            maxLength: 50,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Phone Number.';
              }
              return null;
            },
            inputAction: TextInputAction.next,
            titleLabel: 'Enter Phone Number',
            focusnode: userNumberFocusNode,
            fieldSubmit: (_) {
              FocusScope.of(context).requestFocus(DOBFocusNode);
            },
            controller: userNumberController,
          ),
          MajorTextField(
            icon: Icons.date_range,
            inputType: TextInputType.text,
            maxLength: 50,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Date of Birth.';
              }
              return null;
            },
            inputAction: TextInputAction.next,
            titleLabel: 'Enter Date of Birth',
            focusnode: DOBFocusNode,
            fieldSubmit: (_) {
              FocusScope.of(context).requestFocus(PasswordFocusNode);
            },
            controller: userDOBController,
          ),
          MajorTextField(
            icon: Icons.phonelink_lock,
            inputType: TextInputType.text,
            maxLength: 8,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Password.';
              }
              return null;
            },
            inputAction: TextInputAction.done,
            titleLabel: 'Enter Password',
            focusnode: PasswordFocusNode,
            fieldSubmit: (_) {
//            FocusScope.of(context).requestFocus(PasswordFocusNode);
            },
            controller: userPasswordController,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          if (_formKey.currentState.validate()) {
                            await model.signUpUser(
                              name: userNameController.text.toString(),
                              email: userEmailController.text.toString(),
                              password: userPasswordController.text.toString(),
                              phonenumber: userNumberController.text.toString(),
                              dob: userDOBController.text.toString(),
                            );
                          }
                          setState(() {
                            _isLoading = true;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                splashColor: Colors.amber,
                color: Theme.of(context).accentColor,
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline6,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    userNameController.dispose();
    userNumberController.dispose();
    userDOBController.dispose();
    emailFocusNode.dispose();
    PasswordFocusNode.dispose();
    DOBFocusNode.dispose();
    userNumberFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top) *
                          0.8,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        child: _getCardFields(model),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FlatButton(
                              child: Text(
                                'Login Now',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              onPressed: model.navigateToSignIn,
                              splashColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
