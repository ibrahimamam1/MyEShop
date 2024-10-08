import 'package:e_shop/features/authentication/controller/signup/signup_controller.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsCheckBox extends StatelessWidget {
  const TermsAndConditionsCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;

    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
        const SizedBox(
          width: AppSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${AppTextStrings.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${AppTextStrings.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? AppColors.white : AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? AppColors.white : AppColors.primary,
                  )),
          TextSpan(
              text: '${AppTextStrings.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${AppTextStrings.termsOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? AppColors.white : AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? AppColors.white : AppColors.primary,
                  )),
        ]))
      ],
    );
  }
}
