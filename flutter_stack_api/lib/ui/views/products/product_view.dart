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
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          int prodId = model.getProductList[index].productId;
                          return ProductListItem(
                           productData: model.getProductList[index],
                            nextScreenProduct:
                                model.navigateToAddEditProductwithArgs,
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
