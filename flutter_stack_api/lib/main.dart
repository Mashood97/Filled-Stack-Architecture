import 'package:flutter/material.dart';
import 'package:flutterstackapi/app/locator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';
import './app/router.gr.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        accentColor: Colors.deepOrangeAccent,
        canvasColor: Colors.redAccent,
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
      ),
      initialRoute: Routes.startupViewRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
