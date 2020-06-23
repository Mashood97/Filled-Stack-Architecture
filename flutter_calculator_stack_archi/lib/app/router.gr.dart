// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluttercalculatorstackarchi/ui/views/startup/startupview.dart';
import 'package:fluttercalculatorstackarchi/ui/views/home/homeview.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const all = {
    startupViewRoute,
    homeViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => StartUpView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
