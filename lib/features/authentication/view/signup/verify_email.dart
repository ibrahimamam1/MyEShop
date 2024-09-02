import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/features/authentication/controller/signup/verify_email_controller.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                //Image
                Image(
                  image: const AssetImage(AppImages.verifyIllustration),
                  width: AppHelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Title And Subtitle
                Text(
                  AppTextStrings.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                Text(
                  email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                Text(
                  AppTextStrings.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Buttons
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            controller.checkEmailVerificationStatus(),
                        child: const Text(AppTextStrings.tContinue))),
                const SizedBox(height: AppSizes.spaceBtwItems),
                SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () => controller.sendVerificationEmail(),
                        child: const Text(AppTextStrings.resendEmail))),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            )),
      ),
    );
  }
}
