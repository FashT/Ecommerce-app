
import 'package:ecomm_app/models/wishlist_model.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishLisItems = {};
  Map<String, WishListModel> get getWishList {
    return _wishLisItems;
  }

  bool isProductInWishList({required productId}) {
    return _wishLisItems.containsKey(productId);
  }

  void addOrRemoveProductFromWishList({required String productId}) {
    if (_wishLisItems.containsKey(productId)) {
      _wishLisItems.remove(productId);
    } else {
      _wishLisItems.putIfAbsent(
        productId,
        () => WishListModel(
          wishListId: const Uuid().v4(),
          productId: productId,
        ),
      );
    }

    notifyListeners();
  }

  void clearLocalWishList() {
    _wishLisItems.clear();
    notifyListeners();
  }
}
