import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecomm_app/provider/wishlist_provider.dart';
import 'package:ecomm_app/services/assets_manager.dart';
import 'package:ecomm_app/services/my_app_methods.dart';

import 'package:ecomm_app/widgets/product/products_widget.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_widget_bag.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = '/WishListScreen';
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);
    return wishListProvider.getWishList.isEmpty
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
                label: 'WishList(${wishListProvider.getWishList.length},),',
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
                          wishListProvider.clearLocalWishList();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              builder: (context, index) {
                return ProductsWidget(
                  productId: wishListProvider.getWishList.values
                      .toList()[index]
                      .productId,
                );
              },
              itemCount: wishListProvider.getWishList.length,
              crossAxisCount: 2,
            ),
          );
  }
}
