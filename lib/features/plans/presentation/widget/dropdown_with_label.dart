import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class DropdownWithLabel<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final Widget prefixIcon;
  final String? Function(T?)? validator;
  final double? maxDropdownHeight;
  final double? horizontalContentPadding;

  const DropdownWithLabel({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.prefixIcon,
    this.validator,
    this.maxDropdownHeight = 200,
    this.horizontalContentPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.fromHex("#868DA6"),
          ),
        ),
        DropdownButtonFormField2<T>(
          hint: Text(
            hintText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.onSecondary,
            ),
          ),
          value: value,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalContentPadding ?? 10,
              vertical: 16,
            ),
          ),
          isExpanded: true,
          iconStyleData: IconStyleData(
            icon: const Icon(
              Iconsax.arrow_down_1,
              color: AppColors.outline,
            ),
            iconSize: 18,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: maxDropdownHeight ?? 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 6),
            offset: const Offset(0, -4),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 48,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.pressed)) {
                  return AppColors.onPrimary.withOpacity(0.08);
                }
                return null;
              },
            ),
          ),
          items: items,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
