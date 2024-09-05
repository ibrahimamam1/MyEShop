import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:e_shop/features/shop/models/category_model.dart';
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
}
