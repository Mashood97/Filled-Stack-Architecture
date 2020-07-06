// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutterecommerceuserapp/services/register_all_services.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final registerAllServices = _$RegisterAllServices();
  g.registerLazySingleton<AuthService>(() => registerAllServices.authService);
  g.registerLazySingleton<DialogService>(
      () => registerAllServices.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => registerAllServices.navigationService);
}

class _$RegisterAllServices extends RegisterAllServices {
  @override
  AuthService get authService => AuthService();
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
