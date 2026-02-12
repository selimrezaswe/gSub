import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TabButton({super.key, 
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.onPrimary,
          borderRadius: BorderRadius.circular(99),
          border: isSelected
              ? null
              : Border.all(color: AppColors.outline, width: 1),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      isSelected ? AppColors.onPrimary : AppColors.onSecondary,
                ),
          ),
        ),
      ),
    );
  }
}
