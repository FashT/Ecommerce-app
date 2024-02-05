import 'package:ecomm_app/screen/inner_screens/auth/login.dart';
import 'package:ecomm_app/screen/inner_screens/auth/register_page.dart';
import 'package:ecomm_app/screen/inner_screens/recently_viewed_screen.dart';
import 'package:ecomm_app/screen/inner_screens/wishlist_screen.dart';
import 'package:ecomm_app/services/assets_manager.dart';
import 'package:ecomm_app/services/my_app_methods.dart';

import 'package:ecomm_app/widgets/custom_list_tile.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

import '/widgets/app_name_text.dart';
import '/widgets/title_texts.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameText(),
        leading: Image.asset(AssetsManager.shoppingCart),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Visibility(
                visible: false,
                child: TitleText(
                  label: 'Please login to have ultimate access',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    //  color: Theme.of(context).cardColor,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 3,
                          color: Theme.of(context).colorScheme.background),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage('url'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(label: 'Akinola Tino '),
                      SubtitleText(
                        label: 'fasuhanmitaiwo@yahoo.com',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 24,
              ),
              child: Column(
                children: [
                  const TitleText(label: 'General'),
                  CustomListTile(
                    imagePath: AssetsManager.orderSvg,
                    text: 'All orders',
                    function: () {},
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.wishlistSvg,
                    text: 'Wishlist',
                    function: () {
                      Navigator.pushNamed(context, WishListScreen.routeName);
                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.recent,
                    text: 'Viewed recent',
                    function: () {
                      Navigator.pushNamed(
                          context, RecentlyViewedScreen.routeName);
                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.address,
                    text: 'Address',
                    function: () {},
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(themeProvider.getIsDarkTheme
                        ? 'Dark Theme'
                        : 'Light Theme'),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (user == null) {
                        Navigator.pushNamed(
                          context,
                          LoginScreen.routeName,
                        );
                      } else {
                        await MyAppMethods.showErrorOrWarningDialogue(
                          isError: false,
                          context: context,
                          subtitle: 'Are you sure?',
                          fct: () async {
                            await FirebaseAuth.instance.signOut();
                            if (!mounted) {
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(
                      user == null ? Icons.login : Icons.logout,
                    ),
                    label: Text(
                      user == null ? 'Login' : 'Logout',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
