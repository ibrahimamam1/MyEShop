import 'dart:convert';

import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/products/product_repository.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  //Variables
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  //method to initialise wishlist by reading from storage
  Future<void> initFavourites() async {
    final json = AppLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouriteToStorage();
      AppLoaders.customToast(message: 'Product has been added to the wishlist');
    } else {
      AppLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouriteToStorage();
      favourites.refresh();
      AppLoaders.customToast(
          message: 'Product has been removed from the wishlist');
    }
  }

  void saveFavouriteToStorage() {
    final encodedFavorites = json.encode(favourites);
    AppLocalStorage.instance().saveData('favourites', encodedFavorites);
  }

  Future<List<ProductModel>> fetchFavoriteProductsFromDatabase() async {
    if (favourites.isEmpty) {
      return []; // Return an empty list if there are no favorites
    }
    return await ProductRepository.instance
        .fetchFavouriteProducts(favourites.keys.toList());
  }
}
