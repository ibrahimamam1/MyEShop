import 'package:e_shop/common/styles/spacing_styles.dart';
import 'package:e_shop/common/styles/widgets/login_signup/form_divider.dart';
import 'package:e_shop/common/styles/widgets/login_signup/social_button.dart';
import 'package:e_shop/features/authentication/view/login/widgets/login_form.dart';
import 'package:e_shop/features/authentication/view/login/widgets/login_header.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: AppSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  //logo , title and subtitle
                  LoginHeader(dark: dark),

                  //Form
                  LoginForm(),

                  //Divider
                  const FormDivider(
                    dividerText: AppTextStrings.orSignInWith,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  //Footer
                  SocialButton()
                ],
              ))),
    );
  }
}
