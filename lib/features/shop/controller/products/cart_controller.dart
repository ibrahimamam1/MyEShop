import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/features/shop/controller/products/variation_controller.dart';
import 'package:e_shop/features/shop/models/cart_item_model.dart';
import 'package:e_shop/features/shop/models/product_model.dart';
import 'package:e_shop/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  void addToCart(ProductModel product) {
    //Quantity check
    if (productQuantityInCart.value < 1) {
      AppLoaders.customToast(message: 'Select Quantity');
      return;
    }

    if (product.productType == 'Variable' &&
        variationController.selectedVariation.value.id.isEmpty) {
      AppLoaders.customToast(message: 'Select Variation');
      return;
    }

    //Out of Stock Status
    if (product.productType == 'Variable') {
      if (variationController.selectedVariation.value.stock < 1) {
        AppLoaders.warningSnackBar(
            title: 'Oh Snap!', message: 'Selected variation is out of stock');
        return;
      }
    } else {
      if (product.stock < 1) {
        AppLoaders.warningSnackBar(
            message: 'Selected Productt is Out of Stock', title: 'Oh Snap!');
        return;
      }
    }

    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    //check if already added in cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    AppLoaders.customToast(message: 'Your Product has been added to the cart');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }

    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);
        AppLoaders.customToast(message: 'Product Removed from the cart');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == 'Single') {
      //Reset variation
      variationController.resetSelectedattributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice;

    return CartItemModel(
        productId: product.id,
        title: product.title,
        price: price,
        variationId: variation.id,
        image: isVariation ? variation.image : product.thumbnail,
        brandName: product.brand != null ? product.brand!.name : '',
        selectedvariation: isVariation ? variation.attributeValues : null,
        quantity: quantity);
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    //If Product has no variations then calculate cartEntries and display total number
    // Else make default entries to 0 and show cartEntries when variation is selected

    if (product.productType == 'Single') {
      productQuantityInCart == getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  //update cart values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double totalPrice = 0.0;
    int totalItemCount = 0;

    for (var item in cartItems) {
      totalPrice += (item.price) * item.quantity.toDouble();
      totalItemCount += item.quantity;
    }

    totalCartPrice.value = totalPrice;
    noOfCartItems.value = totalItemCount;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    AppLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        AppLocalStorage.instance().readData<List<dynamic>>('cartitems');

    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);

    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
