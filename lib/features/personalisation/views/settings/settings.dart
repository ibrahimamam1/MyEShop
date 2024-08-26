import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_shop/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:e_shop/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/personalisation/views/addresses/address.dart';
import 'package:e_shop/features/personalisation/views/profile/widgets/profile.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            AppPrimaryHeaderContainer(
                child: Column(
              children: [
                SAppBar(
                    title: Text(
                  'Account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: AppColors.white),
                )),
                const SizedBox(height: AppSizes.spaceBtwSections),

                //User Profile Card
                AppUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen())),
                const SizedBox(height: AppSizes.spaceBtwSections),
              ],
            )),

            //Body
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  //Account Settings
                  const AppSectionHeading(
                    title: 'Account settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery adress',
                    onTap: () => Get.to(() => const UserAdressScreen()),
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add , remove Products and move to checkout',
                    onTap: () {},
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-Progress and Completed Orders',
                    onTap: () {},
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank account',
                    subtitle: 'Withdraw Balance to registered bank account',
                    onTap: () {},
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of All discounted Coupons',
                    onTap: () {},
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'My Notifications',
                    subtitle: 'See All your Notifications',
                    onTap: () {},
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  //App Settings
                  const SizedBox(
                    height: AppSizes.spaceBtwSections,
                  ),
                  const AppSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const AppSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load data',
                      subtitle: 'Upload Your data to Firebase'),
                  AppSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'GeoLocalisation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search Result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  AppSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD image quality',
                    subtitle: 'Set image quality to HD',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  //LogOut Button
                  const SizedBox(
                    height: AppSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwSections * 2.5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
