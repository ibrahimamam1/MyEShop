import 'package:e_shop/features/authentication/controller/onBoarding_controller.dart';
import 'package:e_shop/features/authentication/view/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:e_shop/features/authentication/view/onboarding/widgets/onboarding_next_button.dart';
import 'package:e_shop/features/authentication/view/onboarding/widgets/onboarding_page.dart';
import 'package:e_shop/features/authentication/view/onboarding/widgets/onboarding_skip_button.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: AppImages.onBoardingImage1,
                  title: AppTextStrings.onBoardingTitle1,
                  subtitle: AppTextStrings.onBoardingSubTitle1),
              OnBoardingPage(
                  image: AppImages.onBoardingImage2,
                  title: AppTextStrings.onBoardingTitle2,
                  subtitle: AppTextStrings.onBoardingSubTitle2),
              OnBoardingPage(
                  image: AppImages.onBoardingImage3,
                  title: AppTextStrings.onBoardingTitle3,
                  subtitle: AppTextStrings.onBoardingSubTitle3)
            ],
          ),

          //Skip Button
          onBoardingSkipButton(),

          //Dot Navigation Indicator
          OnBoardingDotNavigation(),

          //Circular Button
          onBoardingNextButton(),
        ],
      ),
    );
  }
}
