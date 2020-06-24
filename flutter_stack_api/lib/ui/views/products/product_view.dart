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
      onModelReady: (model)=>model.getProductList,
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
//                Navigator.of(context).pushNamed(EditAddProduct.routeArgs);
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
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return ProductListItem(
                            title: model.getProductList[index].productName,
                            description:
                                model.getProductList[index].productDescription,
                            imageUrl: model.getProductList[index].productImage,
                            deleteProduct: model.deleteProductByProductId(
                                '1003'),
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
