import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:ecomm_app/provider/products_provider.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitleText(
                        label:
                            'Total(${cartProvider.getCartItems.length} products/ ${cartProvider.getQty()} items)',
                      ),
                    ),
                    SubtitleText(
                      label: '\$${cartProvider.getTotal(productProvider: productProvider)}',
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  
                },
                child: const Text(
                  'Checkout',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
