import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/users/user_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
//      onModelReady: (model)=>model.getUsers(),
      builder: (ctx, model, child) => Scaffold(
        body: Center(
          child: FlatButton(
            onPressed: model.getUsers,
            child: Text('Get Users'),
          ),
        ),
      ),
      viewModelBuilder: () => UserViewModel(),
    );
  }
}
