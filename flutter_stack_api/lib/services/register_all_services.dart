import 'package:flutterstackapi/services/product_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'auth_service.dart';

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
