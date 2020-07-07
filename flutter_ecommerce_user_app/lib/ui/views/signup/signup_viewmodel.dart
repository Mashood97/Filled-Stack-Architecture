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
      final response =
          await _authService.signUpUser(user) as Map<String, dynamic>;
      setBusy(false);

      final responseMessage = response['data']['message'];
      final responseData = response['data']['userData'];
      if (responseMessage == 'Success') {
        _authService.setUserId(responseData['userId']);
        _authService.setUserEmail(responseData['Email']);
        _authService.setUserDOB(responseData['DateOfBirth']);
        _authService.setUserName(responseData['UserName']);
        _authService.setuserNumber(responseData['PhoneNumber']);
        _authService.setUserType(responseData['userType']);
        notifyListeners();
        final userData = json.encode({
          'userId': _authService.getuserId,
          'userEmail': _authService.getEmail,
          'userName': _authService.getusername,
          'userType': _authService.getUserType,
          'userNumber': _authService.getNumber,
          'userDOB': _authService.getUserDOB,
        });
        await SharedPref.init();
        await SharedPref.setAuthdata(userData);

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
    await _navigationService.replaceWith(Routes.homeView);
  }
}
