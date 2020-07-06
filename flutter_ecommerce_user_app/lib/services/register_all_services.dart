import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'auth_services.dart';

@registerModule
abstract class RegisterAllServices {
  @lazySingleton
  NavigationService get navigationService;

  @lazySingleton
  DialogService get dialogService;

  @lazySingleton
  AuthService get authService;
}
