import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();

  Future handleAutoLogin() async {
    bool a = await _authService.autoLogin();
    if (a) {
      _navigationService.replaceWith(Routes.homeView);
    } else {
      _navigationService.replaceWith(Routes.signInView);
    }
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      var d = handleAutoLogin();
      return d;
    } else {
      await prefs.setBool('seen', true);
      return _navigationService.replaceWith(Routes.startUpView);
    }
  }

  void gotoSignIn() async {
    await _navigationService.replaceWith(Routes.signInView);
  }
}
