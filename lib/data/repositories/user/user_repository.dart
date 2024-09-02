import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/personalisation/models/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }
}
