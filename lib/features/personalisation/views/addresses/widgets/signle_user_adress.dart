import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/features/personalisation/controllers/adress_controller.dart';
import 'package:e_shop/features/personalisation/models/adress_model.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppSingleUserAdress extends StatelessWidget {
  const AppSingleUserAdress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;

        return InkWell(
          onTap: onTap,
          child: AppCircularContainer(
            padding: const EdgeInsets.all(AppSizes.md),
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress
                ? AppColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                    ? AppColors.darkGrey
                    : AppColors.grey,
            margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                      color: selectedAddress
                          ? dark
                              ? AppColors.light
                              : AppColors.dark
                          : null),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: AppSizes.sm / 2,
                    ),
                    Text(
                      address.formattedPhoneNo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.sm / 2),
                    Text(
                      address.toString(),
                      softWrap: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
