import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/users/user_viewmodel.dart';
import 'package:flutterstackapi/widgets/user_list_item.dart';
import 'package:stacked/stacked.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      onModelReady: (model) => model.getUserList,
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Manage Users'),

        ),
        body: SafeArea(
          child: SafeArea(
            child: FutureBuilder(
              future: model.getUsers(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => model.getUsers(),
                      backgroundColor: Colors.white,
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          int userId = model.getUserList[index].userId;
                          return UserListItem(
                            model.getUserList[index],
                            model.deleteSingleUser,
                          );
                        },
                        separatorBuilder: (ctx, index) => Divider(),
                        itemCount: model.getUserList.length,
                      ),
                    ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => UserViewModel(),
    );
  }
}
