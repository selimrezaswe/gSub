import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';

class CurrencyTile extends StatelessWidget {
  const CurrencyTile({
    super.key,
    required this.item,
    required this.onTap,
    this.isSelected = false,
  });

  final CurrencyItem item;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.outline,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // ListTile's shape is left for ripple effect match
        ),
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.onPrimaryLight,
            shape: BoxShape.circle,
          ),
          child: Text(
            item.emoji,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        title: Text(
          "${item.code} (${item.symbol})",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.onSecondary,
          ),
        ),
        trailing: Icon(
          Iconsax.tick_circle,
          color: isSelected ? AppColors.primary : AppColors.onSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
