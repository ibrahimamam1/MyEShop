import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/features/personalisation/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  //function to fetch user data based on userId.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  //function to update user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  //function to update single user data field in Firestore.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  /// Function to remove user data from firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  ///function to Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }
}
