import 'dart:convert';

import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/app/router.gr.dart';
import 'package:flutterstackapi/helpers/shared_preferences.dart';
import 'package:flutterstackapi/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  var _message, _userData;

  Future signUpUser(
      {String name,
      String email,
      String password,
      String phonenumber,
      String dob}) async {
    try {
      setBusy(true);
      var result = await _authService.signUpAdmin(
          name, email, password, phonenumber, dob);
      setBusy(false);
      if (result is Map<String, dynamic>) {
        _message = result['data']['message'];
        _userData = result['data']['userData'];
        if (_message == 'Success') {
          print(_message);
          print(_userData);
          _authService.setUserId(_userData['userId'].toString());
          _authService.setUserName(_userData['UserName'].toString());
          _authService.setUserDOB(_userData['DateOfBirth'].toString());
          _authService.setUserEmail(_userData['Email'].toString());
          _authService.setuserNumber(_userData['PhoneNumber'].toString());
          _authService.setUserType(_userData['userType'].toString());
          notifyListeners();
          final authData = json.encode({
            "userId": _authService.getuserId,
            "userEmail": _authService.getEmail,
            "userName": _authService.getusername,
            "userNumber": _authService.getNumber,
            "userDOB": _authService.getUserDOB,
            "userType": _authService.getUserType,
          });
          await SharedPref.init();
          SharedPref.setAuthdata(authData);
          navigateToHome();
        } else {
          await _dialogService.showDialog(
            title: 'Error Occured',
            description: _message,
            buttonTitle: 'OK',
            dialogPlatform: DialogPlatform.Material,
            barrierDismissible: false,
          );
        }

//      navigateToSignUp();
      } else {
        await _dialogService.showDialog(
            title: 'Error Occured', description: _message, buttonTitle: 'OK');
      }
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Error Occured',
          description: 'Can\t Authenticate You!',
          buttonTitle: 'OK');
    }
  }

  void navigateToSignIn() async {
    await _navigationService.navigateTo(Routes.startupViewRoute);
  }

  void navigateToHome() async {
    await _navigationService.replaceWith(Routes.homeViewRoute, arguments: {
      'username': _authService.getusername,
      'userId': _authService.getuserId
    });
  }
}
