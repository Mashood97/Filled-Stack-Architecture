import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final Future deleteProduct;

  ProductListItem(
      {this.title, this.imageUrl, this.description, this.deleteProduct});

// IconButton(
//                icon: Icon(
//                  Icons.add,
//                  color: Colors.blueAccent,
//                ),
//                onPressed: () {
//                  Navigator.of(context).pushNamed(EditAddProduct.routeArgs);
//                },
//                splashColor: Theme.of(context).accentColor,
//              ),
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        shadowColor: Colors.black,
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black),
          ),
          subtitle: Text(
            description,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                splashColor: Theme.of(context).accentColor,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
                splashColor: Theme.of(context).accentColor,
                onPressed: ()=>deleteProduct,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
