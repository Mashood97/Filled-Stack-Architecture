import 'package:auto_route/auto_route_annotations.dart';
import 'package:fluttercalculatorstackarchi/ui/views/home/homeview.dart';
import 'package:fluttercalculatorstackarchi/ui/views/startup/startupview.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartUpView startupViewRoute;

  HomeView homeViewRoute;
}