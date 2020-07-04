import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/app/router.gr.dart';
import 'package:flutterstackapi/services/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class AddEditViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProductService _productService = locator<ProductService>();
  final DialogService _dialogService = locator<DialogService>();

  File _image;
  final picker = ImagePicker();
  int _productId;

  String _prodName;
  String _prodDescp;
  String _prodType;
  String _prodPrice;
  String _prodStockQuantity;
  String _imageUrl;

  var pickedFile;

  String get prodName => _prodName;

  String get prodDescp => _prodDescp;

  String get prodType => _prodType;

  String get prodPrice => _prodPrice;

  String get prodStockQuantity => _prodStockQuantity;

  File get getImage => _image;

  int get productId => _productId;

  String get imageUrl => _imageUrl;

  Future addProduct(Product product) async {
    try {
      final result = await _productService.addProduct(Product(
        productName: product.productName,
        productPrice: product.productPrice,
        stockQuantity: product.stockQuantity,
        productType: product.productType,
        productImage: product.productImage,
        productDescription: product.productDescription,
      ));
      print(result);
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Error',
          description: e.toString(),
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material);
    }
  }

  Future addImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = null;
      _image = File(pickedFile.path);
      print('ADD IMAGE PATH: ${pickedFile.path}');
    } else {
      await _dialogService.showDialog(
          title: 'Error',
          description: 'Please Select valid image',
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material);
    }

    notifyListeners();
  }

  Future updateProuct(int prodId, Product product) async {
    try {
      final result = await _productService.updateAProduct(
          prodId,
          Product(
              productDescription: product.productDescription,
              productImage: product.productImage,
              productType: product.productType,
              stockQuantity: product.stockQuantity,
              productPrice: product.productPrice,
              productName: product.productName,
              productId: product.productId));
      print('Updated Product $result');
    } catch (e) {
      print(e.toString());
      await _dialogService.showDialog(
          title: 'Success', description: 'An Error Occured', buttonTitle: 'OK');
    }
  }

  Future getSingleProduct(var context) async {
    try {
      final route = ModalRoute.of(context).settings.arguments as int;
      _productId = route;
      if (_productId != null) {
        final result = await _productService.getProductByID(_productId)
            as Map<String, dynamic>;
        final message = result['data']['message'];
        if (message == 'product Retrieved') {
          final responseData = result['data']['productData'];

          final find = responseData['productImage']
              .toString()
              .replaceAll(r'uploads\', 'http://192.168.1.105:3000/');

          _prodName = responseData['productName'];
          _prodDescp = responseData['productDescription'];
          _imageUrl = find;

          File x = await urlToFile(_imageUrl);

          _image = File(x.path);
          print('IMAGE PATHHHH :${x.path}');
          _prodType = responseData['productType'];
          _prodPrice = responseData['productPrice'];
          _prodStockQuantity = responseData['StockQuantity'];
        } else {
          await _dialogService.showDialog(
              title: 'Success', description: message, buttonTitle: 'OK');
        }
      } else {
        _prodName = '';
        _prodDescp = '';
        _prodName = '';
        _prodType = '';
        _prodPrice = '';
        _prodStockQuantity = '';
      }
      notifyListeners();
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Success', description: 'An Error Occured', buttonTitle: 'OK');
    }
  }

  Future<File> urlToFile(String imageUrls) async {
    var rng = new Random();

    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;

    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');

    http.Response response = await http.get(imageUrls);

    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  void navigateToProductViewScreen() async {
    await _navigationService.replaceWith(Routes.productViewRoute);
  }
}
