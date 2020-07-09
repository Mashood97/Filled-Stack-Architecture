import 'dart:convert';

import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';
import 'package:flutterecommerceuserapp/helpers/shared_preferences.dart';
import 'package:flutterecommerceuserapp/model/user_model.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:io';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();

  Future signUpUser(User user) async {
    try {
      setBusy(true);
      final response = await _authService.signUpUser(user);
      setBusy(false);
      final responseMessage = response['data']['message'];
      final responseData = response['data']['userData'];
      if (response is Map<String, dynamic>) {
        if (responseMessage == 'Success') {
//          _authService.setUserId(responseData['userId']);
//          _authService.setUserEmail(responseData['Email']);
//          _authService.setUserDOB(responseData['DateOfBirth']);
//          _authService.setUserName(responseData['UserName']);
//          _authService.setuserNumber(responseData['PhoneNumber']);
//          _authService.setUserType(responseData['userType']);
          user = User(
              userDOB: responseData['DateOfBirth'],
              userEmail: responseData['Email'],
              userName: responseData['UserName'],
              userType: responseData['userType'],
              userNumber: responseData['PhoneNumber'],
              userId: responseData['userId']);
          notifyListeners();
          final userData = json.encode({
            'userId': user.userId,
            'userEmail': user.userEmail,
            'userName': user.userName,
            'userType': user.userType,
            'userNumber': user.userNumber,
            'userDOB': user.userDOB,
          });
          await SharedPref.init();
          SharedPref.setAuthdata(userData);

          navigateToHome();
        } else {
          await _dialogService.showDialog(
            title: 'ERROR',
            description: responseMessage,
            buttonTitle: 'OK',
            barrierDismissible: false,
            dialogPlatform: Platform.isAndroid
                ? DialogPlatform.Material
                : DialogPlatform.Cupertino,
          );
        }
      } else {
        await _dialogService.showDialog(
            title: 'Error Occured',
            description: responseMessage,
            buttonTitle: 'OK');
      }
    } catch (e) {
      await _dialogService.showDialog(
        title: 'ERROR',
        description: 'An Error Occured',
        buttonTitle: 'OK',
        barrierDismissible: false,
        dialogPlatform: Platform.isAndroid
            ? DialogPlatform.Material
            : DialogPlatform.Cupertino,
      );
    }
  }

  void navigateToLogin() async {
    await _navigationService.navigateTo(Routes.signInView);
  }

  void navigateToHome() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }
}
