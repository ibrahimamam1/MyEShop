import 'package:e_shop/features/authentication/controller/onboarding/onBoarding_controller.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class onBoardingSkipButton extends StatelessWidget {
  const onBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultSpace,
      child: TextButton(
          child: const Text('Skip'),
          onPressed: () => OnBoardingController.instance.skipPage()),
    );
  }
}
