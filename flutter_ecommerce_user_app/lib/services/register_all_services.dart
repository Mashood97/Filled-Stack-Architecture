import 'package:flutterecommerceuserapp/services/product_service.dart';
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
  @lazySingleton
  ProductService get productService;
}
//flutter pub run build_runner build