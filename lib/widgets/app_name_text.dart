// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:ecomm_app/widgets/title_texts.dart';

class AppNameText extends StatelessWidget {
  final double fontSize;
 const AppNameText({
    Key? key,
    this.fontSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child:  TitleText(
        label: 'Fash Taiwo',
        fontSize: fontSize,
      ),
    );
  }
}
