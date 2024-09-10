import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/controller/products/images_controller.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variabes
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  //Select Attribute and variation
  void onAttributesSelected(
      ProductModel product, attributeName, attributeValue) {
    //when attribute is selected add it to selectedAttributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
        (variation) => _isSameAttributeValues(
            variation.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty());

    //show the selected variation image as a main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    //assign selected variation
    this.selectedVariation.value = selectedVariation;

    //update selected product variation status
    getProductVariationStockStatus();
  }

  //check if selected Attribute matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  //Check Attribute availability / stock in variation
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    final availableVariationAttributeValues = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In stock' : 'Out of Stock';
  }

  // Reset Selected Attributes when switching products
  void resetSelectedattributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
