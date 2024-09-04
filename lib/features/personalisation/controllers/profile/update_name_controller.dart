import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/user/user_repository.dart';
import 'package:e_shop/features/personalisation/controllers/user_controller.dart';
import 'package:e_shop/features/personalisation/views/profile/widgets/profile.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:e_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when homescreen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //Fetch User Record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      AppFullscreenLoader.openLoadingDialog(
          'We are updating your information', AppImages.docerAnimation);

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
      if (!updateUserNameFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //Update User's Name In fireStore
      Map<String, dynamic> name = {
        'Firstname': firstName.text.trim(),
        'Lastname': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //Remove Loader
      AppFullscreenLoader.stopLoading();

      //Show Sucess Message
      AppLoaders.sucessSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated');

      //Redirect
      Get.off(ProfileScreen());
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.errorSnackBar(title: 'Oh  Snap!', message: e.toString());
    }
  }
}
