import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/personalisation/controllers/user_controller.dart';
import 'package:e_shop/features/personalisation/views/profile/widgets/change_name.dart';
import 'package:e_shop/features/personalisation/views/profile/widgets/profile_menu.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
        appBar: const SAppBar(
          showBackArrow: true,
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              children: [
                //Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : AppImages.user;
                        return AppCircularImage(
                          image: image,
                          width: 80,
                          height: 80,
                          isNetworkImage: networkImage.isNotEmpty,
                        );
                      }),
                      TextButton(
                          onPressed: () =>
                              controller.uploadUserProfilePicture(),
                          child: const Text('Change Profile Picture')),
                    ],
                  ),
                ),

                //Details
                const SizedBox(
                  height: AppSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                const AppSectionHeading(
                  title: 'Profile Information',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                AppProfileMenuItem(
                    title: 'First Name',
                    value: controller.user.value.firstName,
                    onPressed: () => Get.to(const ChangeNameScreen())),
                AppProfileMenuItem(
                    title: 'Last Name',
                    value: controller.user.value.lastName,
                    onPressed: () => Get.to(const ChangeNameScreen())),

                const SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),

                //personal Information
                const AppSectionHeading(
                  title: 'Personal Information',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),

                AppProfileMenuItem(
                    title: 'Name',
                    value: controller.user.value.fullName,
                    onPressed: () {}),
                AppProfileMenuItem(
                    title: 'User Name',
                    value: controller.user.value.userName,
                    onPressed: () {}),

                AppProfileMenuItem(
                    title: 'UserId',
                    value: controller.user.value.id,
                    onPressed: () {}),
                AppProfileMenuItem(
                    title: 'Email',
                    value: controller.user.value.email,
                    onPressed: () {}),
                AppProfileMenuItem(
                    title: 'Phone Number',
                    value: controller.user.value.phoneNumber,
                    onPressed: () {}),
                AppProfileMenuItem(
                    title: 'Gender', value: 'Male', onPressed: () {}),
                AppProfileMenuItem(
                    title: 'Date Of Birth',
                    value: '10 Oct, 1994',
                    onPressed: () {}),
                const Divider(),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),

                Center(
                  child: TextButton(
                      onPressed: () => controller.deleteAccountWarningPopup(),
                      child: const Text(
                        'Close Account',
                        style: TextStyle(color: Colors.red),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
