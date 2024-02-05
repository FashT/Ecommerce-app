import 'package:ecomm_app/models/carts_model.dart';
import 'package:ecomm_app/models/products_model.dart';
import 'package:ecomm_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  bool isProductInCart({required productId}) {
    return _cartItems.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItems.update(
      productId,
      (item) => CartModel(
        cartId: item.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.00;
    _cartItems.forEach(
      (key, value) {
        final ProductModel? getCurrentProduct =
            productProvider.findByProdId(value.productId);
        if (getCurrentProduct == null) {
          total += 0;
        } else {
          total +=
              double.parse(getCurrentProduct.productPrice) * value.quantity;
        }
      },
    );
    return total;
  }


int getQty(){
  int total = 0;
  _cartItems.forEach((key, value) {
    total += value.quantity;
  });
  return total;
}

  void removeOneItem({required String productId}){
    _cartItems.remove(productId);
    notifyListeners();
  }
  void clearLocalCart(){
    _cartItems.clear();
    notifyListeners();
  }
}
