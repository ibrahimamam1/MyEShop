import 'package:e_shop/features/authentication/view/signup/signup.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Column(
        children: [
          //Email
          TextFormField(
              decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.direct_right),
            labelText: AppTextStrings.email,
          )),
          const SizedBox(height: AppSizes.spaceBtwInputFields),

          //Password
          TextFormField(
              decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.password_check),
            labelText: AppTextStrings.password,
            suffixIcon: Icon(Iconsax.eye_slash),
          )),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields / 2,
          ),

          //Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Remember Me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(AppTextStrings.rememberMe)
                ],
              ),

              //Forgot Password
              TextButton(
                  onPressed: () {},
                  child: const Text(AppTextStrings.forgetPassword)),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          //Sign In Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {}, child: Text(AppTextStrings.signIn))),
          const SizedBox(height: AppSizes.spaceBtwSections),

          //Sign Up Button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => SignupScreen()),
                  child: Text(AppTextStrings.createAccount))),
          const SizedBox(height: AppSizes.spaceBtwSections),
        ],
      ),
    ));
  }
}
