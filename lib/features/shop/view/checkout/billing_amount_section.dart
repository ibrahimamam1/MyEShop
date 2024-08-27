import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppBillingAmountSection extends StatelessWidget {
  const AppBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Sub Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('SubTotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$256', style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),

        ////Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$10', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),

        //Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$5', style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),

        //Orderr Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$271', style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
      ],
    );
  }
}
