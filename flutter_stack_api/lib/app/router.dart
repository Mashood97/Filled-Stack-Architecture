import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterstackapi/ui/views/AddOrEditProducts/add_edit_view.dart';
import 'package:flutterstackapi/ui/views/home/home_view.dart';
import 'package:flutterstackapi/ui/views/products/product_view.dart';
import 'package:flutterstackapi/ui/views/signin/signin_view.dart';
import 'package:flutterstackapi/ui/views/signup/signup_view.dart';
import 'package:flutterstackapi/ui/views/startup/startup_view.dart';
import 'package:flutterstackapi/ui/views/users/user_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartUpView startupViewRoute;

  SignUpView signUpViewRoute;

  HomeView homeViewRoute;

  SignInView signInViewRoute;

  ProductView productViewRoute;

  AddEditProductView addEditProductViewRoute;

  UserView userView;
}