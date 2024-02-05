import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:ecomm_app/provider/products_provider.dart';
import 'package:ecomm_app/screen/inner_screens/product_details.dart';
import 'package:ecomm_app/widgets/product/heart_button.widget.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatefulWidget {
  final String productId;
  const ProductsWidget({super.key, required this.productId});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                    context, ProductDetailScreen.routeName,
                    arguments: getCurrentProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleText(
                          label: getCurrentProduct.productTitle,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: HeartButtonWidget(
                          productId: getCurrentProduct.productId,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: SubtitleText(
                              label: '\$${getCurrentProduct.productPrice}'),
                        ),
                        Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                          child: IconButton(
                            splashColor: Colors.red,
                            splashRadius: 27,
                            onPressed: () {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrentProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                productId: getCurrentProduct.productId,
                              );
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                productId: getCurrentProduct.productId,
                              )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
