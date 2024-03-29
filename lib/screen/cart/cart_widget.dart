import 'package:ecomm_app/consts/app_const.dart';
import 'package:ecomm_app/models/carts_model.dart';
import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/products_provider.dart';
import 'quantity_bottom_sheet.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct =
        productProvider.findByProdId(cartModelProvider.productId);
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.productImage,
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TitleText(
                                  label: getCurrentProduct.productTitle,
                                  maxLines: 2,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cartProvider.removeOneItem(productId: getCurrentProduct.productId);
                                    },
                                    icon: const Icon(
                                      IconlyLight.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      IconlyLight.heart,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               SubtitleText(
                                label: '\$${getCurrentProduct.productPrice}',
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return  QuantityBottomSheet(cartModel: cartModelProvider,);
                                    },
                                  );
                                },
                                icon: const Icon(
                                  IconlyLight.arrowDown,
                                ),
                                label:  Text('Qty: ${cartModelProvider.quantity}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
