import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  /// Get All categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();

      debugPrint('-------------${list.length}--------');
      return list;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  //Get Sun categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  ///Upload Categories to the cloud firebase

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      //upload all categories along with their image
      final storage = Get.put(AppFirebaseStorageService());

      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);

        //upload image and get its url
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        //Assign URL to Category.image attribute
        category.image = url;

        //store category in db
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (e) {
      throw 'Something went Wrong. Please try again';
    }
  }

  Future<void> uploadCategoryProductsDummyData() async {
    List<Map<String, String>> items = [
      {'ProductId': '1', 'CategoryId': '1'},
      {'ProductId': '12', 'CategoryId': '1'},
      {'ProductId': '13', 'CategoryId': '1'},
      {'ProductId': '5', 'CategoryId': '1'},
      {'ProductId': '10', 'CategoryId': '2'},
      {'ProductId': '11', 'CategoryId': '2'},
      {'ProductId': '22', 'CategoryId': '2'},
      {'ProductId': '8', 'CategoryId': '2'},
      {'ProductId': '9', 'CategoryId': '2'},
      {'ProductId': '16', 'CategoryId': '3'},
      {'ProductId': '17', 'CategoryId': '3'},
      {'ProductId': '18', 'CategoryId': '3'},
      {'ProductId': '19', 'CategoryId': '3'},
      {'ProductId': '20', 'CategoryId': '3'},
      {'ProductId': '5', 'CategoryId': '3'},
      {'ProductId': '6', 'CategoryId': '3'},
      {'ProductId': '7', 'CategoryId': '3'},
      {'ProductId': '14', 'CategoryId': '4'},
      {'ProductId': '2', 'CategoryId': '4'},
      {'ProductId': '21', 'CategoryId': '4'},
      {'ProductId': '3', 'CategoryId': '4'},
      {'ProductId': '4', 'CategoryId': '4'},
    ];

    int i = 1;
    for (var item in items) {
      _db.collection('ProductCategory').doc(i.toString()).set(item);
      i++;
    }
  }
}
