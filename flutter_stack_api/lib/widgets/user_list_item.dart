import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/users/user_viewmodel.dart';

class UserListItem extends StatelessWidget {
  final User userData;

  UserListItem(this.userData);

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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashColor: Colors.green,
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              ),
              onPressed: () {},
            ),
            IconButton(
              splashColor: Colors.red,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
