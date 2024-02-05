import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:ecomm_app/provider/products_provider.dart';
import 'package:ecomm_app/widgets/product/heart_button.widget.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_name_text.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'ProductDetailsScreen';
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentProduct = productsProvider.findByProdId(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 18,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FancyShimmerImage(
              imageUrl: getCurrentProduct!.productImage,
              height: size.height * 0.38,
              width: double.infinity,
              boxFit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          getCurrentProduct.productTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SubtitleText(
                        label: getCurrentProduct.productPrice,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HeartButtonWidget(
                          productId: getCurrentProduct.productId,
                          colors: Colors.blue.shade200,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                if (cartProvider.isProductInCart(
                                    productId: getCurrentProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                    productId: getCurrentProduct.productId);
                              },
                              icon: Icon(
                                cartProvider.isProductInCart(
                                        productId: getCurrentProduct.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart,
                              ),
                              label: Text(
                                cartProvider.isProductInCart(
                                        productId: getCurrentProduct)
                                    ? 'In cart'
                                    : 'Add to cart',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleText(
                        label: 'About this item',
                      ),
                      SubtitleText(
                        label: getCurrentProduct.productCategory,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SubtitleText(
                    label: getCurrentProduct.productDescription,
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
