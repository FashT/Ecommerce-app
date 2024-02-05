import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecomm_app/models/products_model.dart';

import 'package:ecomm_app/services/assets_manager.dart';

import 'package:ecomm_app/widgets/product/products_widget.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  List<ProductModel> productListSearch = [];
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(
            label: passedCategory ?? 'Search',
          ),
          leading: Image.asset(AssetsManager.shoppingBasket),
        ),
        body: productList.isEmpty
            ? const Center(
                child: TitleText(label: 'No products found'),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: searchTextController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          IconlyLight.search,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              searchTextController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                          icon: const Icon(
                            IconlyLight.closeSquare,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        setState(
                          () {
                            productListSearch = productProvider.searchQuery(
                              searchText: searchTextController.text,
                              passedList: productList,
                            );
                          },
                        );
                      },
                      onChanged: (value) {
                        setState(
                          () {
                            productListSearch = productProvider.searchQuery(
                              searchText: searchTextController.text,
                              passedList: productList,
                            );
                          },
                        );
                      },
                    ),
                    if (searchTextController.text.isNotEmpty &&
                        productListSearch.isEmpty) ...[
                      const Center(
                        child: TitleText(
                          label: 'no results found here',
                          fontSize: 30,
                        ),
                      ),
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                        builder: (context, index) {
                          return ProductsWidget(
                            productId: searchTextController.text.isNotEmpty
                                ? productListSearch[index].productId
                                : productList[index].productId,
                          );
                        },
                        itemCount: searchTextController.text.isNotEmpty
                            ? productListSearch.length
                            : productList.length,
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
