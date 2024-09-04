import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/features/personalisation/controllers/user_controller.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:e_shop/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      //custom appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Re-Authenticate User',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //email
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => AppValidator.validateEmail(value),
                  expands: false,
                  decoration: InputDecoration(
                      labelText: AppTextStrings.email,
                      prefixIcon: Icon(Iconsax.direct_right)),
                ),
                SizedBox(height: AppSizes.spaceBtwInputFields),

                //passowrd
                Obx(
                  () => TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        AppValidator.validateEmptyText('Password', value),
                    obscureText: controller.hidepassword.value,
                    expands: false,
                    decoration: InputDecoration(
                        labelText: AppTextStrings.password,
                        prefixIcon: Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                            onPressed: () => controller.hidepassword.value =
                                !controller.hidepassword.value,
                            icon: Icon(Iconsax.eye_slash))),
                  ),
                ),
                //Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPasswordUser(),
                      child: Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
