import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/users/user_viewmodel.dart';

class UserListItem extends StatelessWidget {
  final User userData;
  final deleteUser;

  UserListItem(this.userData, this.deleteUser);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(userData.userName),
        leading: CircleAvatar(
          child: FittedBox(child: Text(userData.userId.toString())),
        ),
        subtitle: Text(userData.userType),
        trailing: IconButton(
          splashColor: Colors.red,
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: ()=>deleteUser(userData.userId),
        ),
      ),
    );
  }
}
