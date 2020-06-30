import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  Widget gridItem(var context, var icon, var title, var func) {
    return GestureDetector(
      onTap: func,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.45,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), side: BorderSide.none),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Theme.of(context).accentColor,
                size: 36,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onModelReady: (model) =>  model.getUserName,
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hello, ${model.getUserName}' ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 24),
                          ),
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 2,
                        ),
                        shrinkWrap: true,
                        itemCount: model.data.length,
                        itemBuilder: (ctx, i) => gridItem(
                          context,
                          model.data[i]['icon'],
                          model.data[i]['title'],
                          model.data[i]['function'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  model.logoutTheUser();
                },
                child: const Icon(Icons.exit_to_app),
                elevation: 15,
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}

//
//
//class ProductListItem extends StatelessWidget {
//  final String title;
//  final String imageUrl;
//  final String description;
//  final  deleteProduct;
//
//  ProductListItem({this.title, this.imageUrl, this.description,this.deleteProduct});
//// IconButton(
////                icon: Icon(
////                  Icons.add,
////                  color: Colors.blueAccent,
////                ),
////                onPressed: () {
////                  Navigator.of(context).pushNamed(EditAddProduct.routeArgs);
////                },
////                splashColor: Theme.of(context).accentColor,
////              ),
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      child: Card(
//        elevation: 5,
//        margin: EdgeInsets.all(10),
//        shadowColor: Colors.black,
//        child: ListTile(
//          title: Text(
//            title,
//            style: Theme.of(context)
//                .textTheme
//                .headline6
//                .copyWith(color: Colors.black),
//          ),
//          subtitle: Text(
//            description,
//            style: Theme.of(context)
//                .textTheme
//                .headline6
//                .copyWith(color: Colors.black),
//          ),
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10),
//          ),
//          leading: CircleAvatar(
//            backgroundImage: NetworkImage(imageUrl),
//          ),
//          trailing: Row(
//            mainAxisSize: MainAxisSize.min,
//            children: [
//
//              IconButton(
//                icon: Icon(
//                  Icons.edit,
//                  color: Colors.green,
//                ),
//                splashColor: Theme.of(context).accentColor,
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(
//                  Icons.delete,
//                  color: Theme.of(context).primaryColor,
//                ),
//                splashColor: Theme.of(context).accentColor,
//                onPressed: ()=>deleteProduct,
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//
