import 'package:e_shop/common/styles/spacing_styles.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed});

  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: AppSpacingStyle.paddingWithAppBarHeight * 2,
            child: Column(
              children: [
                //Image
                Image(
                  image: AssetImage(image),
                  width: AppHelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //Title And Subtitle
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                Text(
                  subtitle,
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
                        onPressed: onPressed,
                        child: const Text(AppTextStrings.tContinue))),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            )),
      ),
    );
  }
}
