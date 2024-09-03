import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/features/authentication/view/password_configuration/reset_password.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:e_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  /// send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      AppFullscreenLoader.openLoadingDialog(
          'Processing Your request', AppImages.docerAnimation);

      //check internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullscreenLoader.stopLoading();
        AppLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message:
                'Please retry when you have an active internert connection');
        return;
      }

      //Form Validation
      if (!forgotPasswordFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //send email to reset passowrd
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //remove loader
      AppFullscreenLoader.stopLoading();

      //show success message
      AppLoaders.sucessSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset Your Password');

      //Redirect
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      AppFullscreenLoader.openLoadingDialog(
          'Processing Your Request', AppImages.docerAnimation);

      //check internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullscreenLoader.stopLoading();
        AppLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message:
                'Please retry when you have an active internert connection');
        return;
      }

      //Form Validation
      if (!forgotPasswordFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //send email to reset passowrd
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //remove loader
      AppFullscreenLoader.stopLoading();

      //show success message
      AppLoaders.sucessSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset Your Password');
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }
}
