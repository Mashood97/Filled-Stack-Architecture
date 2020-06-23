import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterstackapi/ui/views/home/home_view.dart';
import 'package:flutterstackapi/ui/views/signup/signup_view.dart';
import 'package:flutterstackapi/ui/views/startup/startup_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartUpView startupViewRoute;

  SignUpView signUpViewRoute;

  HomeView homeViewRoute;
}