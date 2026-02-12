import 'package:flutter/material.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class NotificationTimePicker extends StatelessWidget {
  const NotificationTimePicker({
    super.key,
    required this.question,
    required this.timeLabel,
    required this.onTimeTap,
  });

  final String question;
  final String timeLabel;
  final VoidCallback onTimeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.notifications_active_outlined,
              size: 20,
              color: AppColors.primary.withOpacity(0.9),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                question,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceLight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Material(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          elevation: 0,
          shadowColor: AppColors.onSecondary.withOpacity(0.08),
          child: InkWell(
            onTap: onTimeTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.outline.withOpacity(0.6),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 20,
                    color: AppColors.onSecondary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      timeLabel,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: AppColors.onSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 22,
                    color: AppColors.onSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
