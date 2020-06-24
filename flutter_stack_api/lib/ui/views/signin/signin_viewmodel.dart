import 'dart:async';
import 'dart:convert';

import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/helpers/shared_preferences.dart';
import 'package:flutterstackapi/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/router.gr.dart';

class SignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  var _message, _userData;




  Future signInWithEmail({String email, String password}) async {
    setBusy(true);
    var result = await _authService.signInAdmin(email, password);
    setBusy(false);
    if (result is Map<String, dynamic>) {
      _message = result['data']['message'];
      _userData = result['data']['userdata'];
      if (_message == 'success') {
        print(_message);
        print(_userData);

        _authService.setUserId(_userData['userId'].toString());
        _authService.setUserName(_userData['userName'].toString());
        _authService.setUserDOB(_userData['userDOB'].toString());
        _authService.setUserEmail(_userData['userEmail'].toString());
        _authService.setuserNumber(_userData['userNumber'].toString());
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
        print('Shared Added');
      } else {
        await _dialogService.showDialog(
            title: 'Error Occured',
            description: _message,
            buttonTitle: 'OK',
            dialogPlatform: DialogPlatform.Material,
            barrierDismissible: false);
      }

//      navigateToSignUp();
    } else {
      await _dialogService.showDialog(
          title: 'Error Occured', description: _message, buttonTitle: 'OK');
    }
  }

  void navigateToSignUp() async {
    await _navigationService.navigateTo(Routes.signUpViewRoute);
  }

  void navigateToHome() async {
    await _navigationService.replaceWith(Routes.homeViewRoute,arguments: {
      'username': _authService.getusername,
      'userId': _authService.getuserId
    });
  }
}
