// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutterecommerceuserapp/ui/views/startup/startup_view.dart';
import 'package:flutterecommerceuserapp/ui/views/signin/signin_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String signInView = '/sign-in-view';
  static const all = <String>{
    startUpView,
    signInView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.signInView, page: SignInView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartUpView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    SignInView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => SignInView(),
        settings: data,
      );
    },
  };
}
