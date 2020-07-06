import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  void gotoSignIn() async {
    await _navigationService.replaceWith(Routes.signInView);
  }
}
