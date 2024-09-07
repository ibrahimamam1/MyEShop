import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/data/repositories/products/product_repository.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      //fetch products
      final products = await productRepository.getFeaturedProducts();

      //asign products
      featuredProducts.assignAll(products);
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Error Fetching Product', message: e.toString());
    } finally {
      //remove Loader
      isLoading.value = false;
    }
  }

  //Get product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == "single") {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  //calculate Discount percentage
  String? calculateSalePercentage(double originalPrice, double? saleprice) {
    if (saleprice == null || saleprice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - saleprice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
