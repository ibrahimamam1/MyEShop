import 'package:e_shop/features/authentication/controller/signup/signup_controller.dart';
import 'package:e_shop/features/authentication/view/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          //First And Last Name
          Row(
            children: [
              Flexible(
                  child: TextFormField(
                controller: controller.firstName,
                validator: (value) =>
                    AppValidator.validateEmptyText('First Name', value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: AppTextStrings.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              )),
              const SizedBox(width: AppSizes.spaceBtwInputFields),
              Flexible(
                  child: TextFormField(
                controller: controller.lastName,
                validator: (value) =>
                    AppValidator.validateEmptyText('Last Name', value),
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
            controller: controller.userName,
            validator: (value) =>
                AppValidator.validateEmptyText('User Name', value),
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
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
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
            controller: controller.phoneNumber,
            validator: (value) => AppValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: AppTextStrings.phoneNo,
                prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),

          //password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => AppValidator.validatePassword(value),
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
              onPressed: () => controller.signup(),
              child: const Text(AppTextStrings.createAccount),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
        ],
      ),
    );
  }
}
