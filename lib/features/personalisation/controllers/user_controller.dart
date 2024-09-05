import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/user/user_repository.dart';
import 'package:e_shop/features/authentication/view/login/login.dart';
import 'package:e_shop/features/personalisation/models/user_model.dart';
import 'package:e_shop/features/personalisation/views/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:e_shop/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  Rx<UserModel> user = UserModel.empty().obs;

  final profileLoading = false.obs;

  final hidepassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Save user Record from any registration provider

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //refresh user record
      await fetchUserRecord();

      //if record is already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //convert name to first name and last name
          final nameParts =
              UserModel.nameparts(userCredentials.user!.displayName ?? '');
          final userName = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //Map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join() : '',
            userName: userName,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          //save data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      AppLoaders.warningSnackBar(
          title: 'Data not Save',
          message: 'Something went wrong while saving your information');
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    }
  }

  //DeleteaccountWarning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(AppSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure tou want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
        confirm: OutlinedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Text('Comfirm')),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text(
              'Cancel',
            )));
  }

  //delete user account
  void deleteUserAccount() async {
    try {
      AppFullscreenLoader.openLoadingDialog(
          'Processing', AppImages.docerAnimation);

      //first re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //Reverify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          AppFullscreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          AppFullscreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  //Re Authenticate before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
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
      if (!reAuthFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticationWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      AppFullscreenLoader.stopLoading();
      Get.offAll(const LoginScreen());
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.warningSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

  /// Upload Profile Image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        // upload image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        //upload user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
      }
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something wnt wrong: $e');
    }
  }
}
