import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/brands/brand_repository.dart';
import 'package:e_shop/data/repositories/products/product_repository.dart';
import 'package:e_shop/features/shop/models/brand_model.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  //Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Something Went Wrong fetching brands', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Error Fetcging brands for category', message: e.toString());
      return [];
    }
  }

  //Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .fetchProductsForBrands(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Something went Wrong Fetching Brands For Products',
          message: e.toString());
      return [];
    }
  }
}
