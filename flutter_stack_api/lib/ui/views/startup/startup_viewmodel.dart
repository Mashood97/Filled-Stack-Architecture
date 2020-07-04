import 'dart:async';
import 'dart:convert';

import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/helpers/shared_preferences.dart';
import 'package:flutterstackapi/services/auth_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/router.gr.dart';

class StartUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  var _message, _userData;

  bool get getUserlogin => _authService.getuserId != null;

  Future getPermissionStatus() async {
    try {
      PermissionHandler permissionHandler = PermissionHandler();


      var permission = await permissionHandler
          .checkPermissionStatus(PermissionGroup.storage);
      permission =
          await permissionHandler.checkPermissionStatus(PermissionGroup.camera);



      if (permission == PermissionStatus.granted) {
        Timer(Duration(seconds: 2), () async {
          bool a = await _authService.autoLogin();
          if (a) {
            _navigationService.replaceWith(Routes.homeViewRoute);
          } else {
            _navigationService.replaceWith(Routes.signInViewRoute);
          }
        });
      } else if (permission == PermissionStatus.denied ||
          permission == PermissionStatus.neverAskAgain ||
          permission == PermissionStatus.restricted ||
          permission == PermissionStatus.unknown) {
        permissionHandler.requestPermissions([PermissionGroup.storage]);
        permissionHandler.requestPermissions([PermissionGroup.camera]);
        getPermissionStatus();
      }
    } catch (e) {
      _dialogService.showDialog(
          title: 'Error',
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material,
          description: 'An Error Occured');
    }
  }
}
