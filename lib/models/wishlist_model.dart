import 'package:flutter/material.dart';

class   WishListModel with ChangeNotifier {
  final String productId;
  final String wishListId;
  

  WishListModel({
    required this.wishListId,
    required this.productId,
    
  });
}
