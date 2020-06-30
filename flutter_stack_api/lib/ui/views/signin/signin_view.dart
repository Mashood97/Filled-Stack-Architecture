import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
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

  var _isLoading = false;


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
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (_formKey.currentState.validate()) {
                          await model.signInWithEmail(
                              email: _emailController.text.toString(),
                              password: _passwordController.text.toString());
                        }
//

                        setState(() {
                          _isLoading = false;
                        });
                      },
                splashColor: Colors.amber,
                color: Theme.of(context).accentColor,
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : Text(
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
//                    AnimationWidget(),
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
                        margin: const EdgeInsets.all(10),
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





//class AnimationWidget extends StatefulWidget {
//  @override
//  AnimationWidgetState createState() {
//    return AnimationWidgetState();
//  }
//}
//
//class AnimationWidgetState extends State<AnimationWidget>
//    with TickerProviderStateMixin {
//  //
//  AnimationController _animationController;
//  Animation<BorderRadius> _borderRadius;
//
//  @override
//  void initState() {
//    super.initState();
//    _animationController =
//    AnimationController(duration: const Duration(seconds: 1), vsync: this)
//      ..addStatusListener((status) {
//        if (status == AnimationStatus.completed) {
//          _animationController.reverse();
//        } else if (status == AnimationStatus.dismissed) {
//          _animationController.forward();
//        }
//      });
//
//    _borderRadius = BorderRadiusTween(
//      begin: BorderRadius.circular(100.0),
//      end: BorderRadius.circular(0.0),
//    ).animate(CurvedAnimation(
//      parent: _animationController,
//      curve: Curves.bounceInOut,
//    ));
//
//    _animationController.forward();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      animation: _borderRadius,
//      builder: (context, child) {
//        return Center(
//          child: Container(
//            child: FlutterLogo(
//              size: 200,
//            ),
//            alignment: Alignment.bottomCenter,
//            width: 350,
//            height: 200,
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                begin: Alignment.topLeft,
//                colors: [Colors.blueAccent, Colors.redAccent],
//              ),
//              borderRadius: _borderRadius.value,
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  @override
//  void dispose() {
//    _animationController.dispose();
//    super.dispose();
//  }
//}
