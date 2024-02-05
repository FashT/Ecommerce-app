import 'package:ecomm_app/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HeartButtonWidget extends StatefulWidget {
  final String productId;
  final Color colors;
  final double size;
  const HeartButtonWidget(
      {super.key,
      this.colors = Colors.transparent,
      this.size = 22,
      required this.productId});

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.colors,
      ),
      child: IconButton(
        style: IconButton.styleFrom(shape: const CircleBorder()),
        onPressed: () {
          wishlistProvider.addOrRemoveProductFromWishList(
              productId: widget.productId);
        },
        icon: Icon(
          wishlistProvider.isProductInWishList(productId: widget.productId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color:
              wishlistProvider.isProductInWishList(productId: widget.productId)
                  ? Colors.red
                  : Colors.grey,
        ),
      ),
    );
  }
}
