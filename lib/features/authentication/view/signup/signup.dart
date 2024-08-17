import 'package:e_shop/common/styles/widgets/login_signup/form_divider.dart';
import 'package:e_shop/common/styles/widgets/login_signup/social_button.dart';
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
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(AppTextStrings.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Form
              const SignUpForm(),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),

              //Divider
              const FormDivider(
                dividerText: AppTextStrings.orSignUpWith,
              ),

              //social button
              const SocialButton(),
            ],
          ),
        )));
  }
}
