import 'package:e_shop/features/authentication/view/signup/verify_email.dart';
import 'package:e_shop/features/authentication/view/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //First And Last Name
          Row(
            children: [
              Flexible(
                  child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: AppTextStrings.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              )),
              const SizedBox(width: AppSizes.spaceBtwInputFields),
              Flexible(
                  child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: AppTextStrings.lastName,
                    prefixIcon: Icon(Iconsax.user)),
              ))
            ],
          ),

          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),

          //userName
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: AppTextStrings.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),

          //Email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: AppTextStrings.email,
                prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),

          //Phone Number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: AppTextStrings.phoneNo,
                prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),

          //password
          TextFormField(
            obscureText: true,
            expands: false,
            decoration: const InputDecoration(
                labelText: AppTextStrings.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          const TermsAndConditionsCheckBox(),

          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),

          //SignUpButton
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              child: const Text(AppTextStrings.createAccount),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
