import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/features/personalisation/views/addresses/add_new_adress.dart';
import 'package:e_shop/features/personalisation/views/addresses/widgets/signle_user_adress.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAdressScreen()),
        backgroundColor: AppColors.primary,
        child: const Icon(Iconsax.add, color: AppColors.white),
      ),
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Adresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              AppSingleUserAdress(selectedAddress: true),
              AppSingleUserAdress(selectedAddress: false)
            ],
          ),
        ),
      ),
    );
  }
}
