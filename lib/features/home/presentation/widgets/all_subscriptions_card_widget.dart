import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/constant/demo.dart';

class AllSubscriptionsCardWidget extends StatelessWidget {
  final bool withOptions;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  const AllSubscriptionsCardWidget({
    super.key,
    this.withOptions = false,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      selected: true,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      selectedTileColor: Colors.white,
      selectedColor: Colors.black,
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8),
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.onPrimaryLight,
          shape: BoxShape.circle,
        ),
        child: Image.memory(
          base64Decode(demoImageBase64),
        ),
      ),
      title: Text(
        "Spotify",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: withOptions
          ? PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                size: 18,
                color: AppColors.subtitleTextColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 1,
              onSelected: (value) {},
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: onEdit,
                  value: "edit",
                  child: Text(
                    "Edit",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ),
                PopupMenuItem(
                  onTap: onDelete,
                  value: "delete",
                  child: Text(
                    "Delete",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ),
              ],
            )
          : Icon(
              Iconsax.arrow_right_3,
              size: 16,
              color: AppColors.subtitleTextColor,
            ),
      subtitle: Text(
        "\$16.00",
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.subtitleTextColor,
        ),
      ),
    );
  }
}
