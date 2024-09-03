import 'package:e_shop/common/styles/spacing_styles.dart';
import 'package:e_shop/features/authentication/controller/forgot_password/forgot_password_controller.dart';
import 'package:e_shop/features/authentication/view/login/login.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              //Image
              Image(
                image: const AssetImage(AppImages.deliveredEmailIllustration),
                width: AppHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),

              //Email , Title And Subtitle
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Text(
                AppTextStrings.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Text(
                AppTextStrings.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),

              //Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(const LoginScreen()),
                      child: const Text(AppTextStrings.done))),
              const SizedBox(height: AppSizes.spaceBtwItems),
              //Buttons
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => ForgotPasswordController.instance
                          .resendPasswordResetEmail(email),
                      child: const Text(AppTextStrings.resendEmail))),
              const SizedBox(height: AppSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
