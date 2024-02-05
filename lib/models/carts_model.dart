import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String productId;
  final String cartId;
  final int quantity;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });
}
