
import 'package:ecomm_app/services/assets_manager.dart';
import 'package:ecomm_app/widgets/subtitle_texts.dart';
import 'package:flutter/material.dart';

import '../widgets/title_texts.dart';


class MyAppMethods {
  static Future<void> showErrorOrWarningDialogue({
    required BuildContext context,
    required,
    required String subtitle,
    bool isError = true,
    required Function fct,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: [
              Image.asset(
                AssetsManager.warning,
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 16,
              ),
              SubtitleText(
                label: subtitle,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: !isError,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const SubtitleText(
                        label: 'Cancel',
                        color: Colors.red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fct();
                    },
                    child: const SubtitleText(
                      label: 'Ok',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: TitleText(
              label: 'Chose option',
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                ),
                TextButton.icon(
                  onPressed: () {
                    removeFCT();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Remove'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
