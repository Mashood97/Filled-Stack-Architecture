import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutterstackapi/helpers/common_api.dart';
import 'package:http_parser/http_parser.dart';
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
       this.productImage,
      @required this.productPrice,
      @required this.productType,
      @required this.stockQuantity});
}

class ProductService {

  DateTime _dateTime = DateTime.now();
  File _image;
  final picker = ImagePicker();



  File get getImage => _image;

  Future addImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
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

  Future addProduct(Product product) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(CommonAPI.addProductUrl));
      request.fields['productName'] = product.productName;
      request.fields['productDescription'] = product.productDescription;
      request.files.add(await http.MultipartFile.fromPath(
          'productImage', product.productImage.path,
          contentType: new MediaType('image', 'jpeg')));

      request.fields['productType'] = product.productType;
      request.fields['productPrice'] = product.productPrice;
      request.fields['StockQuantity'] = product.stockQuantity;
      request.fields['createdProductDatetime'] = _dateTime.toString();
      var res = await request.send();
      return res.reasonPhrase;
    } catch (e) {
      throw e;
    }
  }

  Future deleteAProduct(int prodId) async {
    try {
      final response = await http.delete(
        '${CommonAPI.deleteProductUrl}/$prodId',
      );
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('Response DATA      $responseData');
      return responseData;
    } catch (e) {
      throw e;
    }
  }

  Future updateAProduct(int prodId, Product product) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('${CommonAPI.updateProductUrl}/$prodId'));
      request.fields['productName'] = product.productName;
      request.fields['productDescription'] = product.productDescription;
      request.files.add(await http.MultipartFile.fromPath(
          'productImage', product.productImage.path,
          contentType: new MediaType('image', 'jpeg')));
      request.fields['productType'] = product.productType;
      request.fields['productPrice'] = product.productPrice;
      request.fields['StockQuantity'] = product.stockQuantity;
      request.fields['createdProductDatetime'] = _dateTime.toString();

      var res = await request.send();
      return res.reasonPhrase;
    } catch (e) {
      throw e;
    }
  }

  Future getProductByID(int productId) async {
    try {
      final response = await http.get('${CommonAPI.getProductByIdUrl}/$productId');
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      print('Response data $responseData');
      return responseData;
    } catch (e) {
      throw e;
    }
  }
}
