import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/category/domain/entities/category.dart';
import 'package:subscription_manager/features/category/presentation/widget/category_card_widget.dart';

class AllCategoryScreen extends StatelessWidget {
  const AllCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category(
        name: 'Workspace',
        amount: '\$160.00',
        subscriptions: '10 Subscriptions',
        icon: "icon_money_in",
        details: "Details",
      ),
      Category(
        name: 'Productivity',
        amount: '\$100.00',
        subscriptions: '10 Subscriptions',
        icon: "icon_document_text_1",
        details: "Details",
      ),
      Category(
        name: 'Entertainment',
        amount: '\$60.99',
        subscriptions: '10 Subscriptions',
        icon: "icon_music_list",
        details: "Details",
      ),
      Category(
        name: 'Ai tools',
        amount: '\$160.00',
        subscriptions: '10 Subscriptions',
        icon: "icon_music_list",
        details: "Details",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 60,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.onPrimary,
            foregroundColor: AppColors.onSecondary,
          ),
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "All Category",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCardWidget(
            category: categories[index],
            onEdit: () {
              context.push(
                AppRoutes.editCategory,
                extra: categories[index],
              );
            },
            onDelete: () {
              // TODO: Handle delete
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        shape: const CircleBorder(),
        onPressed: () {
          // context.go(AppRoutes.addCategory);
          context.push(AppRoutes.addCategory);
        },
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
