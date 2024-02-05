import 'package:card_swiper/card_swiper.dart';
import 'package:ecomm_app/consts/app_const.dart';
import 'package:ecomm_app/provider/products_provider.dart';
import 'package:ecomm_app/services/assets_manager.dart';
import 'package:ecomm_app/widgets/product/latest_arrival_prod.dart';
import 'package:ecomm_app/widgets/title_texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_name_text.dart';
import '../widgets/category_rounded_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                width: double.maxFinite,
                child: Swiper(
                  itemCount: AppConstants.bannersImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      AppConstants.bannersImages[index],
                    );
                  },
                  autoplay: true,
                  pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitleText(label: 'Latest arrival'),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productProvider.getProducts[index],
                      child: const LatestArrivalProd(),
                    );
                  },
                  itemCount: 8,
                ),
              ),
              const TitleText(
                label: 'Categories',
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                shrinkWrap: true,
                children: List.generate(
                  AppConstants.categoriesList.length,
                  (index) => CategoryRoundedWidget(
                    image: AppConstants.categoriesList[index].images,
                    name: AppConstants.categoriesList[index].name,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
