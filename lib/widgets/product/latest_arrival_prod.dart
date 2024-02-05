import 'package:ecomm_app/models/products_model.dart';
import 'package:ecomm_app/provider/recently_viewed_prod.dart';
import 'package:ecomm_app/screen/inner_screens/product_details.dart';
import 'package:ecomm_app/widgets/product/heart_button.widget.dart';
import 'package:provider/provider.dart';
import '/widgets/subtitle_texts.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class LatestArrivalProd extends StatelessWidget {
  const LatestArrivalProd({super.key});

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final viewedProductProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProductProvider.addProductToHistory(
            productId: productModel.productId,
          );

          await Navigator.pushNamed(
            context,
            ProductDetailScreen.routeName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    height: size.height * 0.28,
                    width: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: HeartButtonWidget(
                              productId: productModel.productId,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleText(
                        label: '\$${productModel.productPrice}',
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
