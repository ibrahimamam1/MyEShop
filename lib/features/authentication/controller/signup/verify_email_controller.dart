import 'dart:async';

import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/common/widgets/succes_screens/success_screen.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/text_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///Send Email Whenever verify screen appears & set timer for auto redirect

  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect();
  }

  ///Send Email Verification Link
  sendVerificationEmail() async {
    try {
      await AuthenticationRepository.instance.sendVerificationEmail();
      AppLoaders.sucessSnackBar(
          title: 'email Sent ',
          message: 'Please check your inbox and verify your email');
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap! ', message: e.toString());
    }
  }

  ///Timer to automatically redirect Email Verification

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: AppImages.successfullyRegisteredAnimation,
            title: AppTextStrings.yourAccountCreatedTitle,
            subtitle: AppTextStrings.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  ///Manually Check if email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: AppImages.successfullyRegisteredAnimation,
          title: AppTextStrings.yourAccountCreatedTitle,
          subtitle: AppTextStrings.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
