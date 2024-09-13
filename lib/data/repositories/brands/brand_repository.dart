import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/features/shop/models/brand_category_model.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //Get all Brands
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

  //Get Brands for Categories
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    }
  }

  Future<void> uploaddummyBrands() async {
    final List<BrandModel> brands = [
      BrandModel(
          id: '1',
          image:
              'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBrands%2Fadidas-logo.png?alt=media&token=2e8971cc-9e45-407c-b1c3-8662358f5211',
          name: 'Addidas',
          isFeatured: true,
          productsCount: 21),
      BrandModel(
          id: '2',
          image:
              'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBrands%2Facer_logo.png?alt=media&token=4b110b32-e068-472a-9bc7-394a3848fe48',
          name: 'Acer',
          isFeatured: true,
          productsCount: 10),
      BrandModel(
          id: '3',
          image:
              'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBrands%2Fapple-logo.png?alt=media&token=01dc9392-07c5-4225-87dc-fd8f9dcc74ab',
          name: 'Apple',
          isFeatured: true,
          productsCount: 56),
      BrandModel(
          id: '4',
          image:
              'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBrands%2Fikea_logo.png?alt=media&token=8e9f9f87-19c3-4131-9bcd-6590b8987f68',
          name: 'Ikea',
          isFeatured: true,
          productsCount: 62),
      BrandModel(
          id: '5',
          image:
              'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBrands%2Fzara-logo.png?alt=media&token=f2b46ca4-b7b9-4015-8445-de9bf847ba49',
          name: 'Zara',
          isFeatured: true,
          productsCount: 21),
      BrandModel(
          id: '6',
          image:
              'https://firebasestorage.googleapis.com/v0/b/myeshop-ff46b.appspot.com/o/Users%2FImages%2FBrands%2Fnike.png?alt=media&token=748e0a36-e157-4218-8ce2-50497cd99b08',
          name: 'Nike',
          isFeatured: true,
          productsCount: 17),
    ];

    int i = 1;
    for (var brand in brands) {
      _db.collection('Brands').doc(i.toString()).set(brand.toJson());
      i++;
    }
  }

  Future<void> uploadbrandForCategoriesDummydata() async {
    final List<BrandCategoryModel> items = [
      BrandCategoryModel(brandId: '1', categoryId: '1'),
      BrandCategoryModel(brandId: '2', categoryId: '2'),
      BrandCategoryModel(brandId: '3', categoryId: '2'),
      BrandCategoryModel(brandId: '4', categoryId: '4'),
      BrandCategoryModel(brandId: '5', categoryId: '3'),
      BrandCategoryModel(brandId: '6', categoryId: '3'),
    ];

    int i = 1;
    for (var item in items) {
      _db.collection('BrandCategory').doc(i.toString()).set(item.toJson());
      i++;
    }
  }
}
