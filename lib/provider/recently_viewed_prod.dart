
import 'package:ecomm_app/models/view_prod_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProductModel> _viewProdItems = {};
  Map<String, ViewedProductModel> get getViewProdItems {
    return _viewProdItems;
  }

  bool isProductInCart({required productId}) {
    return _viewProdItems.containsKey(productId);
  }

  void addProductToHistory({required String productId}) {
    _viewProdItems.putIfAbsent(
      productId,
      () => ViewedProductModel(
        productId: productId,
        id: const Uuid().v4(),
      ),
    );
    notifyListeners();
  }

  void clearLocalCart() {
    _viewProdItems.clear();
    notifyListeners();
  }
}
