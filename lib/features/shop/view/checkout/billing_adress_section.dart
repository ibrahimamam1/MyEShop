import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/personalisation/controllers/adress_controller.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppBillingAdressSection extends StatelessWidget {
  const AppBillingAdressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      children: [
        AppSectionHeading(
            title: 'Shipping Adress',
            buttonTittle: 'Change',
            onPressed: () => addressController.selectNewAddressPopup(context)),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Random User',
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.grey, size: 16),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      Text('+01 234567890',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Row(
                    children: [
                      const Icon(Icons.location_history,
                          color: Colors.grey, size: 16),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      Expanded(
                        child: Text('random street , random city 1004',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  )
                ],
              )
            : Text(
                'Select Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ],
    );
  }
}
