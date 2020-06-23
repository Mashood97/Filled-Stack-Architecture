import 'package:filled_stack_architecture_flutter/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/router.gr.dart';
//for navigation
class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService= locator<NavigationService>();

  Future navigateToHome() async{
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }
}
