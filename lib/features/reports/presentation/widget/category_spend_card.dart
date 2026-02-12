import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class CategorySpendCard extends StatelessWidget {
  final String label;
  final double amount;
  final double yearlyEstimate;
  final double maxAmount;

  const CategorySpendCard({super.key, 
    required this.label,
    required this.amount,
    required this.yearlyEstimate,
    required this.maxAmount,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (amount / maxAmount).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(999),
              backgroundColor: AppColors.onPrimaryLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yearly Estimated :',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.subtitleTextColor,
                      fontSize: 13,
                    ),
              ),
              Text(
                '\$${yearlyEstimate.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.subtitleTextColor,
                      fontSize: 13,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
