import 'package:e_shop/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppHomeCategories extends StatelessWidget {
  const AppHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSizes.defaultSpace),
      child: Column(
        children: [
          const AppSectionHeading(
            title: 'Popular Categories',
            showActionButton: false,
            textColor: AppColors.white,
          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return AppVerticalImageText(
                    image: AppImages.shoeIcon,
                    title: 'Shoe',
                    onTap: () {},
                  );
                }),
          )
        ],
      ),
    );
  }
}
