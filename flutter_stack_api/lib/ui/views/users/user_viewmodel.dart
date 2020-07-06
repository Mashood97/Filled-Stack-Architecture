import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/router.gr.dart';

class User {
  int userId;
  String userEmail;
  String userName;
  String userNumber;
  String userDOB;
  String userType;

  User(
      {this.userDOB,
      this.userEmail,
      this.userId,
      this.userName,
      this.userNumber,
      this.userType});
}

class UserViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  List<User> _usersList = [];

  List<User> get getUserList => [..._usersList];

  int get getUserListLength => _usersList.length;

  Future getUsers() async {
    try {
      final response = await _userService.getAllUsers();
      final message = response['data']['message'];
      final responseData = response['data']['userData'];
      final List<User> loadedUser = [];
      if (message == 'All User Retrieved') {
        for (var userdata in responseData) {
          loadedUser.add(
            User(
                userId: userdata['userId'],
                userDOB: userdata['userDOB'],
                userEmail: userdata['userEmail'],
                userName: userdata['userName'],
                userNumber: userdata['userNumber'],
                userType: userdata['userType']),
          );
        }
        print(loadedUser);
        _usersList = loadedUser;

        print('RESPONSE--------------- $responseData');
      } else {
        await _dialogService.showDialog(
            title: 'ERROR',
            description: message,
            dialogPlatform: DialogPlatform.Material,
            buttonTitle: 'OK!');
      }
//      notifyListeners();
    } catch (e) {
      await _dialogService.showDialog(
          title: 'ERROR',
          description: 'AN UNKNOWN ERROR OCCURED',
          dialogPlatform: DialogPlatform.Material,
          buttonTitle: 'OK!');
    }
  }

  Future deleteSingleUser(int userId) async {
    try {
      final response = await _userService.deleteUserById(userId);
      final message = response['data']['message'];
      if (message == 'User Deleted Successfully') {
        await _dialogService.showDialog(
            title: 'SUCCESS',
            description: message,
            dialogPlatform: DialogPlatform.Material,
            buttonTitle: 'OK!');
        navigateToHome();
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

  void navigateToHome() async {
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }
}
