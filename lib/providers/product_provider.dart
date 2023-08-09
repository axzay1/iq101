import 'package:flutter/material.dart';
import 'package:iq101/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productData = [];
  bool? _isLoading;

  bool? get isLoading => _isLoading;

  void setLoadingActive(bool loading
      ){
    _isLoading = loading;
    notifyListeners();
  }

  set setProducts(List<ProductModel> products) {
    productData = products ?? [];
    notifyListeners();
  }

  void resetProducts() {
    productData = [];
  }
}