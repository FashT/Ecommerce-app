import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:ecomm_app/screen/cart/cart_bottom_sheet.dart';
import 'package:ecomm_app/screen/cart/cart_widget.dart';
import 'package:ecomm_app/services/assets_manager.dart';
import 'package:ecomm_app/services/my_app_methods.dart';
import 'package:ecomm_app/widgets/empty_widget_bag.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final bool isEmpty = false;
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyWidgetBag(
              imagePath: AssetsManager.shoppingBasket,
              title: 'Your cart is empty ',
              subtitle:
                  'Looks like you didn\'t add anything yet to your \ncart go ahead and start shopping now',
              buttonText: 'Shop now',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleText(
                label: 'Cart(${cartProvider.getCartItems.length},),',
              ),
              leading: Image.asset(
                AssetsManager.shoppingCart,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialogue(
                      isError: false,
                        context: context,
                        subtitle: 'Remove items',
                        fct: () {
                          cartProvider.clearLocalCart();
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values.toList().reversed.toList()[index],
                        child: const CartWidget(),
                      );
                    },
                    itemCount: cartProvider.getCartItems.length,
                  ),
                ),
              ],
            ),
            bottomSheet: const CartBottomSheet(),
          );
  }
}
