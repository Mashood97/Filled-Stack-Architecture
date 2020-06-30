import 'package:flutter/material.dart';
import 'package:flutterstackapi/ui/views/products/product_viewmodel.dart';
import 'package:flutterstackapi/widgets/product_ListItem.dart';
import 'package:stacked/stacked.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      onModelReady: (model) => model.getProductList, // ye dikha kahan p h
      builder: (ctx, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Manage Products'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                model.navigateToAddEditProduct();
              },
              splashColor: Theme.of(context).accentColor,
            ),
          ],
        ),
        body: SafeArea(
          child: SafeArea(
            child: FutureBuilder(
              future: model.getRefreshedData(),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => model.getRefreshedData(),
                      backgroundColor: Colors.white,
                      child:  ListView.separated(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                int prodId =
                                    model.getProductList[index].productId;
                                print('PRODUCT IN VIEW    ${prodId}');
                                print(
                                    'PRODUCT IN VIEW TYPE   ${model.getProductList[index].productId.runtimeType}');
                                //run kr
                                //this is the masla i guess yahan se me method pass kr raha hn list item me
                                //let memcheck
                                // error dikha kia ara ha // yar masla yeh hai error nahi araha koi neche yeh int to string araha
                                //hai jb ke sirf provider se kia tha pehle to aesa kuch scene nahi tha yahan krne se yeh araa hai.
                                //me run krta hn dekho phir
                                //hoskta hai onmodel ready ka masla ho
                                return ProductListItem(
                                  title:
                                      model.getProductList[index].productName,
                                  prodId: prodId,
                                  description: model
                                      .getProductList[index].productDescription,
                                  imageUrl:
                                      model.getProductList[index].productImage,
                                  deleteProduct: model.deleteProductByProductId,
                                );
                              },
                              separatorBuilder: (ctx, index) => Divider(),
                              itemCount: model.getProductList.length,
                            ),
                    ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ProductViewModel(),
    );
  }
}
