import 'dart:io';

import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/model/user_model.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();
  final List<User> _userList = [];

  List<User> get getUserList => [..._userList];

  int get getUserlistLength => _userList.length;

  Future signInUser(String email, String password) async {
    final response =
        await _authService.signInUser(email, password) as Map<String, dynamic>;
    final message = response['data']['message'];
    final responseData = response['data']['userdata'];
    if (responseData['userType'] == 'user' && message == 'success') {
      print('RESPONSE DATAAAA ===== $responseData');
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
  }
}
