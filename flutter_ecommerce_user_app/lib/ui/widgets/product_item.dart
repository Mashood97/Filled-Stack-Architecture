import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final products;

  ProductItem(this.products);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: FadeInImage(
          placeholder: AssetImage('assets/images/loading.png'),
          image: NetworkImage(products.productImage
              .toString()
              .replaceAll(r'uploads\', 'http://192.168.1.105:3000/')),
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            products.productName,
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
