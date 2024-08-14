import 'package:e_shop/common/styles/widgets/succes_screens/success_screen.dart';
import 'package:e_shop/features/authentication/view/login/login.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
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
                  'someone@gmail.com',
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
                        onPressed: () => Get.to(() => SuccessScreen(
                              image: AppImages.staticSuccessIllustration,
                              title: AppTextStrings.yourAccountCreatedTitle,
                              subtitle:
                                  AppTextStrings.yourAccountCreatedSubTitle,
                              onPressed: () =>
                                  Get.to(() => const LoginScreen()),
                            )),
                        child: const Text(AppTextStrings.tContinue))),
                const SizedBox(height: AppSizes.spaceBtwItems),
                SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(AppTextStrings.resendEmail))),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            )),
      ),
    );
  }
}
