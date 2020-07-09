import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(
    DevicePreview(
      usePreferences: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            locale: DevicePreview.of(context).locale,
            // <--- Add the locale
            builder: DevicePreview.appBuilder,
            title: 'Khareed-Lo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.deepOrangeAccent,
              accentColor: Colors.deepPurpleAccent,
              canvasColor: Colors.white,
              textTheme: TextTheme(
                headline6: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: 0.6,
                ),
                headline4: GoogleFonts.raleway(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 0.6,
                ),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: Routes.startUpView,
            onGenerateRoute: Router().onGenerateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
          )
        : CupertinoApp(
            locale: DevicePreview.of(context).locale,
            // <--- Add the locale
            builder: DevicePreview.appBuilder,
            theme: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                textStyle: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: 0.6,
                ),
                navTitleTextStyle: GoogleFonts.raleway(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            initialRoute: Routes.startUpView,
            onGenerateRoute: Router().onGenerateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
          );
  }
}
