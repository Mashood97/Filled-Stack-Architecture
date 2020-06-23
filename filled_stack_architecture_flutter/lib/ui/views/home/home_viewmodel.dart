import 'package:filled_stack_architecture_flutter/app/locator.dart';
import 'package:filled_stack_architecture_flutter/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';



class HomeViewModel extends BaseViewModel{
  String _title ='Home View';
  int _counter = 0;

  NavigationService _navigationService = locator<NavigationService>();
  int get counter => _counter;
  String get getTitle => '$_title $_counter';


  void navigatetoStartup()=> _navigationService.navigateTo(Routes.startUpViewRoute);
}