import 'package:flutter/material.dart';
import 'package:iq101/model/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<ProductModel> favoriteData = [];
  List<ProductModel> cartData = [];

  List<ProductModel> get cartItems => cartData;

  set setProducts(List<ProductModel> products) {
    favoriteData = products ?? [];
    notifyListeners();
  }

  set setCart(List<ProductModel> products) {
    cartData = products ?? [];
    notifyListeners();
  }

  void removeItemCart(ProductModel product) {
    cartData.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void clearCart(){
    cartData = [];
    notifyListeners();
  }

  void resetFavorite() {
    favoriteData = [];
  }

  void resetCart(){
    cartData = [];
  }
}