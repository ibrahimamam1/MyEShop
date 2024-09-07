import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //Get all Categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    }
  }
}
