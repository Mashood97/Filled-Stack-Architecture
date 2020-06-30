import 'dart:io';
import 'package:flutterstackapi/app/locator.dart';
import 'package:flutterstackapi/services/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddEditViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProductService _productService = locator<ProductService>();
  final DialogService _dialogService = locator<DialogService>();

  File _image;
  final picker = ImagePicker();

  File get getImage => _image;

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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
//      _filePath = _image.uri.toFilePath();
    } else {
      await _dialogService.showDialog(
          title: 'Error',
          description: 'Please Select valid image',
          buttonTitle: 'OK',
          dialogPlatform: DialogPlatform.Material);
    }

    notifyListeners();
  }


}
