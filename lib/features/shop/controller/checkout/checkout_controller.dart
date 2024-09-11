import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/shop/controller/checkout/widgets/payment_tile.dart';
import 'package:e_shop/features/shop/models/payment_method_model.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: AppImages.paypal);
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppSectionHeading(
                        title: 'Select Payment Method',
                        showActionButton: false),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    AppPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Paypal', image: AppImages.paypal)),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    AppPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Visa', image: AppImages.visa)),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    AppPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'MasterCard', image: AppImages.masterCard)),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                  ],
                ),
              ),
            ));
  }
}
