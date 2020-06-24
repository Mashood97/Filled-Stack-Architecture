import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterstackapi/ui/views/signin/signin_viewmodel.dart';
import 'package:flutterstackapi/widgets/major_text_field.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatefulWidget {
  @override
  _StartUpViewState createState() => _StartUpViewState();
}

class _StartUpViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
  }

  Widget getCardFields(var model, var context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SignIn with Us',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          MajorTextField(
            icon: Icons.email,
            inputType: TextInputType.emailAddress,
            maxLength: 50,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Email.';
              }
              return null;
            },
            inputAction: TextInputAction.next,
            titleLabel: 'Enter Email Address',
            fieldSubmit: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            controller: _emailController,
          ),
          MajorTextField(
            icon: Icons.phonelink_lock,
            inputType: TextInputType.text,
            maxLength: 50,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Password.';
              }
              return null;
            },
            inputAction: TextInputAction.done,
            titleLabel: 'Enter Password',
            focusnode: _passwordFocusNode,
            fieldSubmit: (_) {
//                            FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            controller: _passwordController,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  try {
                    if (_formKey.currentState.validate()) {
                      model.signInWithEmail(
                          email: _emailController.text.toString(),
                          password: _passwordController.text.toString());
                      model.navigateToHome();
                    }
                  } catch (e) {
                    print(e);

//                  model.showErrorDialog(context, e.toString());
                  }
                },
                splashColor: Colors.amber,
                color: Theme.of(context).accentColor,
                child: Text(
                  'Login!',
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
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
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
                          0.6,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin:const EdgeInsets.all(10),
                        child: getCardFields(model, context),
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
                                'Register Now',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              onPressed: model.navigateToSignUp,
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
      viewModelBuilder: () => SignInViewModel(),
    );
  }
}
