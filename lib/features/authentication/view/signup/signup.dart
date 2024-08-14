import 'package:e_shop/common/styles/widgets/login_signup/form_divider.dart';
import 'package:e_shop/common/styles/widgets/login_signup/social_button.dart';
import 'package:e_shop/features/authentication/view/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:e_shop/features/authentication/view/signup/widgets/signup_form.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppHelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(AppTextStrings.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Form
              SignUpForm(),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const TermsAndConditionsCheckBox(),

              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),

              //SignUpButton
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(AppTextStrings.createAccount),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Divider
              FormDivider(
                dividerText: AppTextStrings.orSignUpWith,
              ),

              //social button
              const SocialButton(),
            ],
          ),
        )));
  }
}
