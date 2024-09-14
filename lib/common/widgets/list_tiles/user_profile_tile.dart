import 'package:e_shop/common/widgets/images/app_circular_image.dart';
import 'package:e_shop/features/personalisation/controllers/user_controller.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppUserProfileTile extends StatelessWidget {
  const AppUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: AppCircularImage(
        isNetworkImage: true,
        image: controller.user.value.profilePicture,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Obx(
        () => Text(
          controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: AppColors.white),
        ),
      ),
      subtitle: Obx(
        () => Text(
          controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: AppColors.white),
        ),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: AppColors.white,
          )),
    );
  }
}
