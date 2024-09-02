import 'package:e_shop/common/widgets/loaders/animation-loader.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFullscreenLoader {
  //opens a full-screen loading dialog with a given text and animation

  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
              canPop: false,
              child: Container(
                color: AppHelperFunctions.isDarkMode(Get.context!)
                    ? AppColors.dark
                    : AppColors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 250),
                    AppAnimationLoaderWidget(text: text, animation: animation),
                  ],
                ),
              ),
            ));
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
