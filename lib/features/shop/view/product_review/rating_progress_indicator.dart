import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class AppRatingProgressIndicator extends StatelessWidget {
  const AppRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
      Expanded(
        flex: 11,
        child: SizedBox(
          width: AppDeviceUtils.getScreenWidth(context) * 0.5,
          child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: AppColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(AppColors.primary)),
        ),
      )
    ]);
  }
}
