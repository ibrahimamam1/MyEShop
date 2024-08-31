import 'package:e_shop/features/authentication/view/login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
    print("You are supposed ot be at ");
    print(currentPageIndex.value);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage(); //get instance of local storage

      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
    } else {
      currentPageIndex.value++;
      pageController.jumpToPage(currentPageIndex.value);
    }
  }
}
