import 'dart:convert';
import 'dart:io';

import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';
import 'package:flutterecommerceuserapp/helpers/shared_preferences.dart';
import 'package:flutterecommerceuserapp/model/user_model.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();
  List<User> _userList = [];

  List<User> get getUserList => [..._userList];

  int get getUserlistLength => _userList.length;





  Future signInUser(String email, String password) async {
    try {
      final response = await _authService.signInUser(email, password)
          as Map<String, dynamic>;
      final message = response['data']['message'];
      final responseData = response['data']['userdata'];
      final List<User> _loadedUser = [];
      if (responseData['userType'] == 'user' && message == 'success') {
        _loadedUser.add(
          User(
            userId: responseData['userId'],
            userType: responseData['userType'],
            userName: responseData['userName'],
            userEmail: responseData['userEmail'],
            userNumber: responseData['userNumber'],
            userDOB: responseData['userDOB'],
            createdDateTime: responseData['createdDateTime'],
          ),
        );
          _userList = _loadedUser;
        final userData = json.encode({
          'userId': responseData['userId'],
          'userEmail': responseData['userEmail'],
          'userName':  responseData['userName'],
          'userType': responseData['userType'],
          'userNumber': responseData['userNumber'],
          'userDOB': responseData['userDOB'],
        });
        await SharedPref.init();
        SharedPref.setAuthdata(userData);

        navigateToHome();
      } else {
        await _dialogService.showDialog(
          title: 'ERROR!',
          description: 'No User Found',
          buttonTitle: 'OK',
          barrierDismissible: false,
          dialogPlatform: Platform.isAndroid
              ? DialogPlatform.Material
              : DialogPlatform.Cupertino,
        );
      }
    } catch (e) {
      await _dialogService.showDialog(
        title: 'ERROR',
        description: 'AUTH FAILED',
        buttonTitle: 'OK',
        dialogPlatform: Platform.isAndroid
            ? DialogPlatform.Material
            : DialogPlatform.Cupertino,
        barrierDismissible: false,
      );
    }
  }

  void navigateToHome() async {
    await _navigationService.replaceWith(Routes.homeView);
  }
  void navigateToSignup()async{
    await _navigationService.navigateTo(Routes.signUpView);

  }

  void showDialog(String title,String description,String buttonTitle,DialogPlatform platform)async{
    await _dialogService.showDialog(
        title: title,
        description: description,
        dialogPlatform: platform,
        buttonTitle: buttonTitle
    );
  }

}
