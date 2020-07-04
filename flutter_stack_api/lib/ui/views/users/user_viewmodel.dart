import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future getUsers() async {
    try {
      final response = await _userService.getAllUsers();
      final message = response['data']['message'];
      if (message == 'All User Retrieved') {
        final responseData = response['data']['userData'];

        print('RESPONSE--------------- $responseData');
      } else {
        await _dialogService.showDialog(
            title: 'ERROR',
            description: message,
            dialogPlatform: DialogPlatform.Material,
            buttonTitle: 'OK!');
      }
    } catch (e) {
      await _dialogService.showDialog(
          title: 'ERROR',
          description: 'AN UNKNOWN ERROR OCCURED',
          dialogPlatform: DialogPlatform.Material,
          buttonTitle: 'OK!');
    }
  }
}
