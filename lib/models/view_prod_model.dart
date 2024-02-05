import 'package:flutter/material.dart';

class ViewedProductModel with ChangeNotifier {
  final String productId;
  final String id;

  ViewedProductModel({
    required this.productId,
    required this.id,

  });
}
