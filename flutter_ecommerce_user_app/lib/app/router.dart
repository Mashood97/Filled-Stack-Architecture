import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterecommerceuserapp/ui/views/signin/signin_view.dart';
import 'package:flutterecommerceuserapp/ui/views/signup/signup_view.dart';
import 'package:flutterecommerceuserapp/ui/views/startup/startup_view.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AdaptiveRoute(
    page: StartUpView,
    initial: true,
  ),
  AdaptiveRoute(page: SignInView),
  AdaptiveRoute(page: SignUpView),
])
class $Router {}
