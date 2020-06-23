import 'package:fluttercalculatorstackarchi/app/locator.dart';
import 'package:fluttercalculatorstackarchi/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToHome() async{
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }
}
