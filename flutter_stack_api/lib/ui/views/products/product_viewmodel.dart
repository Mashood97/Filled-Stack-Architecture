import 'dart:io';

import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/app/router.gr.dart';
import 'package:flutterstackapi/services/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProductService _productService = locator<ProductService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Product> _productList = [];
  DateTime _dateTime = DateTime.now();
  File _image;
  final picker = ImagePicker();
  String _filePath;

  List<Product> get getProductList => [..._productList];

  int get getProductListLength => _productList.length;

  File get getImage => _image;

  String get getFilePath => _filePath;

  Future<void> getRefreshedData() async {
    try {
      final responseData = await _productService.getAllProducts();
      final message = responseData['data']['message'];
      final getProductData = responseData['data']['productData'];

      final List<Product> loadedProduct = [];
      if (message == 'product Retrieved') {
        for (var x in getProductData) {
          final find = x['productImage']
              .toString()
              .replaceAll(r'uploads\', 'http://192.168.1.105:3000/');

          print(x['productId'].runtimeType);
          loadedProduct.add(
            Product(
              productId: x['productId'],
              productName: x['productName'],
              productDescription: x['productDescription'],
              productImage: find,
              productType: x['productType'],
              productPrice: x['productPrice'],
              stockQuantity: x['StockQuantity'],
            ),
          );
        }

        _productList = loadedProduct;
      } else {
        await _dialogService.showDialog(
            title: 'Error', description: message, buttonTitle: 'OK');
      }
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Error', description: e.toString(), buttonTitle: 'OK');
    }
  }

  Future<void> deleteProductByProductId(int prodId) async {
    try {
      final result =
          await _productService.deleteAProduct(prodId) as Map<String, dynamic>;
      //run
      final message = result['data']['message'];
      if (message != 'Product Deleted Successfully') {
        await _dialogService.showDialog(
            title: 'Error', description: message, buttonTitle: 'OK');
      } else {
        await _dialogService.showDialog(
            title: 'Success', description: message, buttonTitle: 'OK');
        navigateToHome();
      }
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Success', description: 'An Error Occured', buttonTitle: 'OK');
    }
//    notifyListeners();
  }

  void navigateToAddEditProduct() async {
    await _navigationService.navigateTo(Routes.addEditProductViewRoute);
  }

  void navigateToAddEditProductwithArgs(int prodId) async {
    await _navigationService.navigateTo(Routes.addEditProductViewRoute,
        arguments: prodId);
  }

  void navigateToHome() async {
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }
}
