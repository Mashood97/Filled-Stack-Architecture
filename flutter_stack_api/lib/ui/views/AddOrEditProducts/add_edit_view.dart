
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterstackapi/services/product_service.dart';
import 'package:flutterstackapi/ui/views/AddOrEditProducts/add_edit_viewmodel.dart';
import 'package:flutterstackapi/widgets/major_text_field.dart';
import 'package:stacked/stacked.dart';

class AddEditProductView extends StatefulWidget {
  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProductView> {
  final _formKey = GlobalKey<FormState>();

  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productTypeController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _prodDescriptionfocusNode = FocusNode();
  final _prodTypefocusNode = FocusNode();
  final _prodPricefocusNode = FocusNode();
  final _prodQuantityfocusNode = FocusNode();

  var _isLoading = false;

  Widget getCardFieldsForMobile(var provData) {
    return Column(
      children: [
        provData.getImage == null
            ? Icon(
                Icons.image,
                size: 90,
                color: Theme.of(context).accentColor,
              )
            : CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(provData.getImage),
              ),
//
//        CircleAvatar(
//                backgroundImage: MemoryImage(),
//                radius: 30,
//              ),
        SizedBox(
          height: 5,
        ),
        RaisedButton(
          shape: StadiumBorder(),
          onPressed: () {
            provData.addImage();
          },
          child: Text(
            'Add Image',
            style: Theme.of(context).textTheme.headline6,
          ),
          elevation: 5,
          color: Theme.of(context).accentColor,
        ),
        MajorTextField(
          icon: Icons.add_circle_outline,
          titleLabel: 'Enter Product Name',
          inputAction: TextInputAction.next,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter product name';
            }
            return null;
          },
          maxLength: 50,
          inputType: TextInputType.text,
          fieldSubmit: (_) {
            FocusScope.of(context).requestFocus(_prodDescriptionfocusNode);
          },
          controller: _productNameController,
        ),
        MajorTextField(
          icon: Icons.description,
          titleLabel: 'Enter Product Description',
          inputAction: TextInputAction.next,
          maxLines: 3,
          focusnode: _prodDescriptionfocusNode,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter product description';
            }
            return null;
          },
          maxLength: 200,
          inputType: TextInputType.text,
          fieldSubmit: (_) {
            FocusScope.of(context).requestFocus(_prodTypefocusNode);
          },
          controller: _productDescriptionController,
        ),
        MajorTextField(
          icon: Icons.category,
          titleLabel: 'Enter Product Type',
          inputAction: TextInputAction.next,
          focusnode: _prodTypefocusNode,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter product type';
            }
            return null;
          },
          maxLength: 10,
          inputType: TextInputType.text,
          fieldSubmit: (_) {
            FocusScope.of(context).requestFocus(_prodPricefocusNode);
          },
          controller: _productTypeController,
        ),
        MajorTextField(
          icon: Icons.attach_money,
          titleLabel: 'Enter Product Price',
          inputAction: TextInputAction.next,
          focusnode: _prodPricefocusNode,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter product price';
            }
            return null;
          },
          maxLength: 10,
          inputType: TextInputType.number,
          fieldSubmit: (_) {
            FocusScope.of(context).requestFocus(_prodQuantityfocusNode);
          },
          controller: _productPriceController,
        ),
        MajorTextField(
          icon: Icons.storage,
          titleLabel: 'Enter Product Stock Quantity',
          inputAction: TextInputAction.done,
          focusnode: _prodQuantityfocusNode,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter product stock quantity';
            }
            return null;
          },
          maxLength: 10,
          inputType: TextInputType.number,
          controller: _productQuantityController,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Theme.of(context).accentColor,
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Save',
                      style: Theme.of(context).textTheme.headline6,
                    ),
              onPressed: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await provData.addProduct(
                        Product(
                          productName: _productNameController.text.toString(),
                          productDescription:
                              _productDescriptionController.text.toString(),
                          productImage: provData.getImage,
                          productType: _productTypeController.text.toString(),
                          productPrice: _productPriceController.text.toString(),
                          stockQuantity:
                              _productQuantityController.text.toString(),
                        ),
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.pop(context);
                    },
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _prodDescriptionfocusNode.dispose();
    _productTypeController.dispose();
    _prodTypefocusNode.dispose();
    _productPriceController.dispose();
    _prodPricefocusNode.dispose();
    _productQuantityController.dispose();
    _prodQuantityfocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEditViewModel>.reactive(
        builder: (ctx, model, child) => Scaffold(
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).viewInsets.bottom -
                                  10) *
                              0.95,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: getCardFieldsForMobile(model),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => AddEditViewModel());
  }
}
