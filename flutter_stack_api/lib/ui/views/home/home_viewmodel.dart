import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/app/router.gr.dart';
import 'package:flutterstackapi/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();

  Future logoutTheUser() async {
    final result = await _authService.logoutUser();
    if (result is bool) {
      if (result) {
        navigatetoSignin();
      }
    } else {
      await _dialogService.showDialog(
        title: 'Error Occured',
        buttonTitle: 'OK',
        description: 'Failed',
        barrierDismissible: false,
        dialogPlatform: DialogPlatform.Material,
      );
    }
  }

  void navigatetoSignin() async {
    await _navigationService.navigateTo(Routes.startupViewRoute);
  }
}
