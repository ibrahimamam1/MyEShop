import 'package:e_shop/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final color = AppHelperFunctions.getColor(text);
    return ChoiceChip(
      label: color != null ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? AppColors.white : null),
      avatar: color != null
          ? AppCircularContainer(
              width: 50,
              height: 50,
              backgroundColor: color,
            )
          : null,
      shape: color != null ? const CircleBorder() : null,
      labelPadding: color != null ? const EdgeInsets.all(0) : null,
      padding: color != null ? const EdgeInsets.all(0) : null,
      selectedColor: Colors.green,
      backgroundColor: Colors.transparent,
    );
  }
}
