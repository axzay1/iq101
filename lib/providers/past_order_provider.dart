import 'package:flutter/material.dart';
import 'package:iq101/model/product_model.dart';

class PastOrderProvider extends ChangeNotifier {
  List<ProductModel> pastOrderData = [];




  set setProducts(List<ProductModel> products) {
    pastOrderData = products ?? [];
    notifyListeners();
  }

  void resetProducts() {
    pastOrderData = [];
  }
}