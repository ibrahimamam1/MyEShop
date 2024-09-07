import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  // Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get limited featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based on brands
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshop = await query.get();
      final List<ProductModel> productList = querySnapshop.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();

      return productList;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
