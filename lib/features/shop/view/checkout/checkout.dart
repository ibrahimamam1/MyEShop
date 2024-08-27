import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/common/widgets/products/cart/coupon_widget.dart';
import 'package:e_shop/common/widgets/succes_screens/success_screen.dart';
import 'package:e_shop/features/shop/view/cart/widgets/all_cart_tems.dart';
import 'package:e_shop/features/shop/view/checkout/billing_amount_section.dart';
import 'package:e_shop/features/shop/view/checkout/billing_payment_section.dart';
import 'package:e_shop/navigation_menu.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
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
            onPressed: () => Get.to(() => SuccessScreen(
                image: AppImages.successfulPaymentIcon,
                title: 'Payment Sucessfull',
                subtitle: "Your Item Will be Shipped Soon",
                onPressed: () => Get.offAll(() => const NavigationMenu()))),
            child: const Text('Checkout \$256.8')),
      ),
    );
  }
}
