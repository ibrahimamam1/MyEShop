import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/data/repositories/user/user_repository.dart';
import 'package:e_shop/features/authentication/view/signup/verify_email.dart';
import 'package:e_shop/features/personalisation/models/user_model.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variables
  final email = TextEditingController();
  final userName = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs; //observable for hiding/showing password
  final phoneNumber = TextEditingController();
  final privacyPolicy = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //signup
  Future<void> signup() async {
    try {
      //start loading
      //AppFullscreenLoader.openLoadingDialog(
      //'Processing', AppImages.staticSuccessIllustration);

      //check internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppLoaders.errorSnackBar(
            title: 'No Internet Connection',
            message:
                'Please retry when you have an active internert connection');
        return;
      }

      //Form Validation
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      //Privacy Policy
      if (!privacyPolicy.value) {
        AppLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create an account you must accept our privacy policy');
        return;
      }

      //Register user in the firebase authentication and save user
      final userCredentials = await AuthenticationRepository.instance
          .registerWithEmailAndPassowrd(
              email.text.trim(), password.text.trim());

      //save user data in firestore
      final newUser = UserModel(
        id: userCredentials.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //remove loader
      //AppFullscreenLoader.stopLoading();

      //show success Message
      AppLoaders.sucessSnackBar(
          title: 'Congratulations',
          message: 'Your Account have been created verify email to continue');

      //move to verify email screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      //handle exception
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
