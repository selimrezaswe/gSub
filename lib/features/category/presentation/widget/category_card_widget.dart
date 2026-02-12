import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/constant/app_icons.dart';
import 'package:subscription_manager/features/category/domain/entities/category.dart';

class CategoryCardWidget extends StatelessWidget {
  final Category category;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CategoryCardWidget({
    super.key,
    required this.category,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.onPrimaryLight,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcon.iconById(category.icon)!.assetPath,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColors.onSecondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.amount,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subtitleTextColor,
                          ),
                    ),
                  ],
                ),
              ),
              Text(
                category.subscriptions,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtitleTextColor,
                    ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: AppColors.subtitleTextColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit?.call();
                  } else if (value == 'delete') {
                    onDelete?.call();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "edit",
                    child: Text(
                      "Edit",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                            color: AppColors.subtitleTextColor,
                          ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text(
                      "Delete",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                            color: AppColors.subtitleTextColor,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
