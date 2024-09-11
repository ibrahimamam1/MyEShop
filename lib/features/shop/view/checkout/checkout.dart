import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/common/widgets/products/cart/coupon_widget.dart';
import 'package:e_shop/features/shop/controller/products/cart_controller.dart';
import 'package:e_shop/features/shop/controller/products/order_controller.dart';
import 'package:e_shop/features/shop/view/cart/widgets/all_cart_tems.dart';
import 'package:e_shop/features/shop/view/checkout/billing_adress_section.dart';
import 'package:e_shop/features/shop/view/checkout/billing_amount_section.dart';
import 'package:e_shop/features/shop/view/checkout/billing_payment_section.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:e_shop/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final orderController = Get.put(OrderController());
    final subtotal = cartController.totalCartPrice.value;
    final totalAmount =
        AppPricingCalculator.calculateTotalPrice(subtotal, 'US');
    return Scaffold(
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Order Review',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Items in Cart
              const AppAllCartItems(showAddRemoveButtons: false),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Coupoun TextField
              const AppCouponCode(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              //Billing Section
              AppCircularContainer(
                showBorder: true,
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: dark ? AppColors.black : AppColors.white,
                child: const Column(
                  children: [
                    //pricing
                    AppBillingAmountSection(),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    //divider
                    Divider(),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    //payment Methods
                    AppBillingPaymentSection(),

                    //Address
                    AppBillingAdressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      //CheckOut Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subtotal > 0
                ? () => orderController.processOrder(totalAmount)
                : AppLoaders.errorSnackBar(
                    title: 'Empty Cart', message: 'Add items in the cart'),
            child: Text('Checkout \$$totalAmount')),
      ),
    );
  }
}
