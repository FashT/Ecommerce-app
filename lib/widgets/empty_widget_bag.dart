import '../widgets/subtitle_texts.dart';
import '/widgets/title_texts.dart';
import 'package:flutter/material.dart';

class EmptyWidgetBag extends StatelessWidget {
  final String imagePath, title, subtitle, buttonText;

  const EmptyWidgetBag({super.key, required this.imagePath, required this.title, required this.subtitle, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: size.height * 0.35,
              width: double.infinity,
            ),
            const TitleText(
              label: 'Whoops!',
              color: Colors.red,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 20),
             SubtitleText(
              label:
                  subtitle,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
             const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
              ),
              onPressed: () {},
              child:  Text(
                buttonText,
                style: const TextStyle(
                  backgroundColor: Colors.blue,fontSize: 22,
                ),
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
