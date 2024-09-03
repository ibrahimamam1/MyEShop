import 'package:e_shop/features/authentication/controller/login/login_controller.dart';
import 'package:e_shop/features/authentication/view/password_configuration/forgot_password.dart';
import 'package:e_shop/features/authentication/view/signup/signup.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
          child: Column(
            children: [
              //Email
              TextFormField(
                  controller: controller.email,
                  validator: (value) => AppValidator.validateEmail(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: AppTextStrings.email,
                  )),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              //password
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Password', value),
                  obscureText: controller.hidePassword.value,
                  expands: false,
                  decoration: InputDecoration(
                      labelText: AppTextStrings.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye))),
                ),
              ),
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
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value)),
                      const Text(AppTextStrings.rememberMe)
                    ],
                  ),

                  //Forgot Password
                  TextButton(
                      onPressed: () => Get.to(() => ForgotPassWord()),
                      child: const Text(AppTextStrings.forgetPassword)),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.emailAndPasswordLogin(),
                      child: const Text(AppTextStrings.signIn))),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Sign Up Button
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.to(() => const SignupScreen()),
                      child: const Text(AppTextStrings.createAccount))),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ));
  }
}
