import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/features/personalisation/controllers/adress_controller.dart';
import 'package:e_shop/features/personalisation/views/addresses/widgets/add_new_adress.dart';
import 'package:e_shop/features/personalisation/views/addresses/widgets/signle_user_adress.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                //use key to trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.getAllUserAddresses(),
                builder: (context, snapshot) {
                  final widget = AppCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);

                  if (widget != null) return widget;

                  //otherwise data found
                  final addresses = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addresses.length,
                      itemBuilder: (_, index) => AppSingleUserAdress(
                          address: addresses[index],
                          onTap: () =>
                              controller.selectedAddress(addresses[index])));
                }),
          ),
        ),
      ),
    );
  }
}
