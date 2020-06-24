import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutterstackapi/helpers/common_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
      @required this.productImage,
      @required this.productPrice,
      @required this.productType,
      @required this.stockQuantity});
}

class ProductService {
  List<Product> _productList = [];
  DateTime _dateTime = DateTime.now();
  File _image;
  final picker = ImagePicker();
  String _filePath;

  List<Product> get getProductList => [..._productList];

  int get getProductListLength => _productList.length;

  File get getImage => _image;

  String get getFilePath => _filePath;

//  Future imageePost(Product product) async {
////    String fileName = basename();
//    try {
//      var request =
//      http.MultipartRequest('POST', Uri.parse(ApiUrl.addProductUrl));
//      request.fields['productName'] = product.productName;
//      request.fields['productDescription'] = product.productDescription;
////    request.fields['productImage'] = fileName;
//      request.files.add(await http.MultipartFile.fromPath(
//          'productImage', product.productImage.path,
//          contentType: new MediaType('image', 'jpeg')));
//
//      request.fields['productType'] = product.productType;
//      request.fields['productPrice'] = product.productPrice;
//      request.fields['StockQuantity'] = product.stockQuantity;
//      request.fields['createdProductDatetime'] = _dateTime.toString();
//      var res = await request.send();
//
//      print(res.reasonPhrase);
//
//      notifyListeners();
//    } catch (e) {
//      throw e;
//    }
//  }

  Future addImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);
    _filePath = _image.uri.toFilePath();
  }

  Future getAllProducts() async {
    try {
      final response = await http.get(CommonAPI.getProductUrl);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      return responseData;
    } catch (e) {
      throw e;
    }
  }

  Future deleteAProduct(int ProdId) async {
    final response = await http.post(CommonAPI.deleteProductUrl, headers: {
      "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
    }, body: {
      'productId': ProdId,
    });
    print(response);
    final responseData = json.decode(response.body) as Map<String, String>;
    print(responseData);
//    final message = responseData['data']['message'];
//    if (message != 'Product Deleted Successfully') {
//      throw HttpException(message);
//    }
  }

//  Future deleteAProduct(var prodId) async {
//    try {
//      final response = await http.post(CommonAPI.deleteProductUrl, headers: {
//        "content-type": "application/x-www-form-urlencoded; charset=UTF-8",
//      }, body: {
//        'productId': prodId,
//      });
//      final responseData = json.decode(response.body);
//      print(responseData['data']['message']);
//
//      return responseData['data']['message'];
//    } catch (e) {
//      print(e);
//    }
//  }
}
