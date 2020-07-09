import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();

  Future logoutUser() async {
    await _authService.logoutUser();
    await _navigationService.clearStackAndShow(Routes.signInView);
  }
}
