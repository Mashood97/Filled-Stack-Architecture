import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/services/auth_services.dart';
import 'package:flutterecommerceuserapp/services/product_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutterecommerceuserapp/app/locator.dart';
import 'package:flutterecommerceuserapp/app/router.gr.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthService _authService = locator<AuthService>();
  final ProductService _productService = locator<ProductService>();

  List<Product> _productList = [];

  List<Product> get getProductList => [..._productList];

  int get getProductListLength => _productList.length;

  Future logoutUser() async {
    await _authService.logoutUser();
    await _navigationService.clearStackAndShow(Routes.signInView);
  }

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
}
