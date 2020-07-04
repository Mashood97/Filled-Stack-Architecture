// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutterstackapi/ui/views/startup/startup_view.dart';
import 'package:flutterstackapi/ui/views/signup/signup_view.dart';
import 'package:flutterstackapi/ui/views/home/home_view.dart';
import 'package:flutterstackapi/ui/views/signin/signin_view.dart';
import 'package:flutterstackapi/ui/views/products/product_view.dart';
import 'package:flutterstackapi/ui/views/AddOrEditProducts/add_edit_view.dart';
import 'package:flutterstackapi/ui/views/users/user_view.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const signUpViewRoute = '/sign-up-view-route';
  static const homeViewRoute = '/home-view-route';
  static const signInViewRoute = '/sign-in-view-route';
  static const productViewRoute = '/product-view-route';
  static const addEditProductViewRoute = '/add-edit-product-view-route';
  static const userView = '/user-view';
  static const all = {
    startupViewRoute,
    signUpViewRoute,
    homeViewRoute,
    signInViewRoute,
    productViewRoute,
    addEditProductViewRoute,
    userView,
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
      case Routes.signUpViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.signInViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignInView(),
          settings: settings,
        );
      case Routes.productViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ProductView(),
          settings: settings,
        );
      case Routes.addEditProductViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddEditProductView(),
          settings: settings,
        );
      case Routes.userView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => UserView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
