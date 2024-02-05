import 'package:ecomm_app/screen/search_screen.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:flutter/material.dart';

class CategoryRoundedWidget extends StatelessWidget {
  final String name;
  final String image;

  const CategoryRoundedWidget(
      {super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image, //You just missed this added name im place of image lol
            height: 50,
            width: 50,
          ),
          SubtitleText(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
