import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/shop/models/banner_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //Get all banners
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Upload dummy data to firestore database
  Future<void> uploadBannersToFireStore() async {
    try {
      final BannerModel banner1 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-2.jpg?alt=media&token=1965ea31-0ef0-49c7-8033-d2014eef15be",
          targetScreen: "",
          active: true);

      final BannerModel banner2 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-3.jpg?alt=media&token=83024da1-5931-4a6e-b00c-4c75d04fd181",
          targetScreen: "",
          active: true);

      final BannerModel banner3 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-4.jpg?alt=media&token=a162163c-dd31-420d-b746-23b4531f482d",
          targetScreen: "",
          active: true);

      final BannerModel banner4 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-5.jpg?alt=media&token=91f2b428-4842-4ea7-943e-faa2bcf37e66",
          targetScreen: "",
          active: false);
      final BannerModel banner5 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-6.jpg?alt=media&token=52180723-5afa-494f-ad92-12afb62c9750",
          targetScreen: "",
          active: false);
      final BannerModel banner6 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-7.jpg?alt=media&token=9a4aa180-875c-4c92-a0da-8fbc80761549",
          targetScreen: "",
          active: true);
      final BannerModel banner7 = BannerModel(
          imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBanners%2Fpromo-banner-8.jpg?alt=media&token=f399907e-5348-46d7-88bd-d2e293387350",
          targetScreen: "",
          active: false);

      _db
          .collection('Banners')
          .doc("banner1")
          .set(banner1.toJson())
          .onError((e, _) => print("Error writing document: $e"));
      _db
          .collection('Banners')
          .doc("banner2")
          .set(banner2.toJson())
          .onError((e, _) => print("Error writing document: $e"));
      _db
          .collection('Banners')
          .doc("banner3")
          .set(banner3.toJson())
          .onError((e, _) => print("Error writing document: $e"));
      _db
          .collection('Banners')
          .doc("banner4")
          .set(banner4.toJson())
          .onError((e, _) => print("Error writing document: $e"));
      _db
          .collection('Banners')
          .doc("banner5")
          .set(banner5.toJson())
          .onError((e, _) => print("Error writing document: $e"));
      _db
          .collection('Banners')
          .doc("banner6")
          .set(banner6.toJson())
          .onError((e, _) => print("Error writing document: $e"));
      _db
          .collection('Banners')
          .doc("banner7")
          .set(banner7.toJson())
          .onError((e, _) => print("Error writing document: $e"));
    } catch (e) {
      throw 'Error Uploading Banners';
    }
  }
}
