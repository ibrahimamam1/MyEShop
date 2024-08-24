import 'package:e_shop/common/widgets/appBar/appbar.dart';
import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/features/personalisation/views/profile/widgets/profile_menu.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const AppCircularImage(
                        image: AppImages.user,
                        width: 80,
                        height: 80,
                      ),
                      TextButton(
                          onPressed: () {},
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

                //personal Information
                const AppSectionHeading(
                  title: 'Personal Information',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),

                AppProfileMenuItem(
                    title: 'UserId', value: '213734', onPressed: () {}),
                AppProfileMenuItem(
                    title: 'Email',
                    value: 'random@random.com',
                    onPressed: () {}),
                AppProfileMenuItem(
                    title: 'Phone Number',
                    value: '+8801894670871',
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
                      onPressed: () {},
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
