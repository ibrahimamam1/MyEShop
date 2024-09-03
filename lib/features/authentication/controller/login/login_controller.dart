import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/features/personalisation/controllers/user_controller.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:e_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //variables
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();

  final rememberMe = false.obs;
  final hidePassword = true.obs;

  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    loadSavedCredentials();
  }

  // Load saved credentials if they exist
  void loadSavedCredentials() {
    final savedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final savedPassword = localStorage.read('REMEMBER_ME_PASSWORD');
    if (savedEmail != null && savedPassword != null) {
      email.text = savedEmail;
      password.text = savedPassword;
      rememberMe.value = true;
    }
  }

  //signup
  Future<void> emailAndPasswordLogin() async {
    try {
      // //start loading
      AppFullscreenLoader.openLoadingDialog(
          'logging you in...', AppImages.docerAnimation);

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
      if (!loginFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //Save Data if Remember Me is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //log user in
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassowrd(email.text.trim(), password.text.trim());

      //remove loader
      AppFullscreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      //handle exception
      AppFullscreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// -- Goole sign in and Authentication
  Future<void> googleSignIn() async {
    try {
      //Start Loader
      AppFullscreenLoader.openLoadingDialog(
          'Loggin you In', AppImages.docerAnimation);

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
      if (!loginFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //Save Data if Remember Me is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //google authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      //remove loader
      AppFullscreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
