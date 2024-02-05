import 'package:ecomm_app/consts/app_const.dart';
import 'package:ecomm_app/provider/carts_provider.dart';
import 'package:ecomm_app/provider/products_provider.dart';
import 'package:ecomm_app/provider/recently_viewed_prod.dart';
import 'package:ecomm_app/provider/wishlist_provider.dart';
import 'package:ecomm_app/screen/inner_screens/auth/forget_password_screen.dart';
import 'package:ecomm_app/screen/inner_screens/auth/login.dart';
import 'package:ecomm_app/screen/inner_screens/recently_viewed_screen.dart';

import 'package:ecomm_app/screen/inner_screens/wishlist_screen.dart';
import 'package:ecomm_app/screen/root_screens.dart';
import 'package:ecomm_app/screen/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import '/provider/theme_provider.dart';
import '/screen/inner_screens/product_details.dart';

import '/consts/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen/inner_screens/auth/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: AppConstants.apiKey,
          appId: AppConstants.appId,
          messagingSenderId: AppConstants.messagingSenderId,
          projectId: AppConstants.projectId,
          storageBucket: AppConstants.storageBucket,
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SelectableText(
                    'An error has been occurred ${snapshot.error}'),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => ViewedProdProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => WishlistProvider(),
            ),
            Consumer<ThemeProvider>(
              builder: (
                context,
                themeProvider,
                child,
              ) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: Styles.themeData(
                      isDarkTheme: themeProvider.getIsDarkTheme,
                      context: context),
                  home: const RootScreen(),
                  routes: {
                    ProductDetailScreen.routeName: (context) =>
                        const ProductDetailScreen(),
                    WishListScreen.routeName: (context) =>
                        const WishListScreen(),
                    RecentlyViewedScreen.routeName: (context) =>
                        const RecentlyViewedScreen(),
                      RegisterPageScreen.routeName:(context) => const RegisterPageScreen(),
                    ForgetPasswordScreen.routeName: (context) =>
                        const ForgetPasswordScreen(),
                    SearchScreen.routeName: (context) => const SearchScreen(),
                    LoginScreen.routeName:(context) => const LoginScreen(),
                  },
                );
              },
            )
          ],
        );
      },
    );
  }
}
