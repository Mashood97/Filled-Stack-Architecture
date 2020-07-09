import 'dart:convert';

import 'package:flutterecommerceuserapp/helpers/common_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Product {
  String productName,
      productDescription,
      productType,
      productPrice,
      stockQuantity;
  int productId;
  var productImage;

  Product(
      {this.productId,
        @required this.productName,
        @required this.productDescription,
        this.productImage,
        @required this.productPrice,
        @required this.productType,
        @required this.stockQuantity});
}
class ProductService{


  Future getAllProducts() async {
    try {
      final response = await http.get(CommonAPi.getProductUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      return responseData;
    } catch (e) {
      throw e;
    }
  }
}