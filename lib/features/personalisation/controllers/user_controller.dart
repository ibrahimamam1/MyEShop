import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/user/user_repository.dart';
import 'package:e_shop/features/personalisation/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  /// Save user Record from any registration provider

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        //convert name to first name and last name
        final nameParts =
            UserModel.nameparts(userCredentials.user!.displayName ?? '');
        final userName =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

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
    } catch (e) {
      AppLoaders.warningSnackBar(
          title: 'Data not Save',
          message: 'Something went wrong while saving your information');
    }
  }
}
