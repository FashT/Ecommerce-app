import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecomm_app/provider/recently_viewed_prod.dart';
import 'package:ecomm_app/services/assets_manager.dart';
import 'package:ecomm_app/widgets/product/products_widget.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/empty_widget_bag.dart';





class RecentlyViewedScreen extends StatefulWidget {
   static const routeName = '/RecentlyViewedScreen';
  const  RecentlyViewedScreen({super.key});

  @override
  State< RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State< RecentlyViewedScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewedProductProvider = Provider.of<ViewedProdProvider>(context);
    return  viewedProductProvider.getViewProdItems.isEmpty
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
                label: 'Recently viewed(${viewedProductProvider.getViewProdItems.length},),',
              ),
              leading: Image.asset(
                AssetsManager.shoppingCart,
              ),
              actions: [
                IconButton(
                  onPressed: () {

                    
                        },
                  
                  icon:  const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              builder: (context, index) {
                return ProductsWidget(
                  productId: viewedProductProvider.getViewProdItems.values
                      .toList()[index]
                      .productId,
                );
              },
              itemCount: viewedProductProvider.getViewProdItems.length,
              crossAxisCount: 2,
            ),
        );
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const TitleText(
            label: 'Recently Viewed(5)',
          ),
          leading: Image.asset(AssetsManager.shoppingBasket),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              
              Expanded(
                child: DynamicHeightGridView(
                  builder: (context, index) {
                    return const ProductsWidget(productId: '',);
                  },
                  itemCount: 30,
                  crossAxisCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
