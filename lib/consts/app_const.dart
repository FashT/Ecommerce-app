

import 'package:ecomm_app/models/categories_model.dart';
import 'package:ecomm_app/services/assets_manager.dart';

class AppConstants {
  static String productImageUrl =
      "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-mens-shoes-jBrhbr.png";

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Phones",
      images: AssetsManager.mobiles,
      name: "Phones",
    ),
    CategoryModel(
      id: "Laptops",
      images: AssetsManager.pc,
      name: "Laptops",
    ),
    CategoryModel(
      id: "Electronics",
      images: AssetsManager.electronics,
      name: "Electronics",
    ),
    CategoryModel(
      id: "Watches",
      images: AssetsManager.watch,
      name: "Watches",
    ),
    CategoryModel(
      id: "Shoes",
      images: AssetsManager.shoes,
      name: "Shoes",
    ),
    CategoryModel(
      id: "Books",
      images: AssetsManager.book,
      name: "Books",
    ),
    CategoryModel(
      id: "Cosmetics",
      images: AssetsManager.cosmetics,
      name: "Cosmetics",
    ),
  ];
  static String apiKey =  "AIzaSyAOcNI0DFvZrQO7i1NpIP4N7cReI_QIOps";
  static String appId = "1:384058309738:android:ce05041d6c03054ef05e13";
  static String messagingSenderId =  "384058309738";
  static String projectId =  "384058309738";
  static String storageBucket =' fashtdev-shopping.appspot.com';
}
