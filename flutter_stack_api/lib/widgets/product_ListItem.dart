import 'package:flutter/material.dart';
import 'package:flutterstackapi/services/product_service.dart';

class ProductListItem extends StatelessWidget {
  final deleteProduct;
  final nextScreenProduct;
  final Product productData;

//  final data;
//  final a;
//  ProductListItem(this.data,this.a);
  //
  ProductListItem({
    this.productData,
    this.nextScreenProduct,
    this.deleteProduct,
  });

  //title: model.getProductList[index].productName,
  //                            description:
  //                                model.getProductList[index].productDescription,
  //                            imageUrl: model.getProductList[index].productImage,
  //                            deleteProduct: model.deleteProductByProductId(
  //                                model.getProductList[index].productId),

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
    return productData.productId == null
        ? Center(
            child: Text('No Product Found'),
          )
        : GestureDetector(
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              shadowColor: Colors.black,
              child: ListTile(
                title: Text(
                  productData.productName,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black),
                ),
                subtitle: Text(
                  productData.productDescription,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.black),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(productData.productImage),
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
                      onPressed: () => nextScreenProduct(productData.productId),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                      splashColor: Theme.of(context).accentColor,
                      onPressed: () => deleteProduct(productData.productId),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
