import 'package:auto_route/auto_route_annotations.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/startup/startup_view.dart';
@MaterialAutoRouter()
class $Router{
  @initial
  StartUpView startUpViewRoute;
  HomeView homeViewRoute;
}