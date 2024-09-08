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

  // Get Products based on a query
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

  // Get Products based on brands
  Future<List<ProductModel>> fetchProductsForBrands(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshop = limit == -1
          ? await _db
              .collection('Products')
              .where('BrandId', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('BrandId', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products = querySnapshop.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based on category
  Future<List<ProductModel>> fetchProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['ProductId'] as String)
          .toList();

      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  // Get Products based favourites
  Future<List<ProductModel>> fetchFavouriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
