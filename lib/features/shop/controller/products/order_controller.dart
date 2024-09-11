import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/common/widgets/succes_screens/success_screen.dart';
import 'package:e_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:e_shop/data/repositories/order/order_repository.dart';
import 'package:e_shop/features/personalisation/controllers/adress_controller.dart';
import 'package:e_shop/features/shop/controller/checkout/checkout_controller.dart';
import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/models/order_model.dart';
import 'package:e_shop/navigation_menu.dart';
import 'package:e_shop/utils/constants/enums.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  //Variable
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutcontroller = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  //fetch User's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      AppLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  //Add Methods for order processing
  void processOrder(double totalAmount) async {
    try {
      //start Loader
      AppFullscreenLoader.openLoadingDialog(
          'Processing your Order', AppImages.docerAnimation);

      //Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId!.isEmpty) return;

      //Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutcontroller.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      //save order to firestore
      await orderRepository.saveOrder(order, userId);

      //update cart status
      cartController.clearCart();

      //show success screen
      Get.off(() => SuccessScreen(
          image: AppImages.orderCompleteAnimation,
          title: 'Payment Success',
          subtitle: 'Your Items will be delivered Soon',
          onPressed: () => Get.offAll(const NavigationMenu())));
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
