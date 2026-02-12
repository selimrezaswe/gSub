import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class BillingHistoryTile extends StatelessWidget {
  final String icon;
  final String month;
  final String date;
  final double amount;

  const BillingHistoryTile({
    super.key,
    required this.icon,
    required this.month,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // App icon
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: AppColors.onPrimary,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Image.memory(
              base64Decode(icon),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 14),

          // Month & date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        color: AppColors.subtitleTextColor,
                      ),
                ),
              ],
            ),
          ),

          // Amount chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.onPrimary,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              "\$${amount.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.subtitleTextColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
