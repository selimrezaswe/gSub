import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/app_details/domain/entities/app_details_param.dart';
import 'package:subscription_manager/features/app_details/presentation/widget/billing_history_tile.dart';
import 'package:subscription_manager/features/app_details/presentation/widget/detail_row.dart';
import 'package:subscription_manager/features/app_details/presentation/widget/tab_button.dart';

class AppDetailScreen extends StatefulWidget {
  final AppDetailsParam param;

  const AppDetailScreen({super.key, required this.param});

  @override
  State<AppDetailScreen> createState() => _AppDetailScreenState();
}

class _AppDetailScreenState extends State<AppDetailScreen> {
  int _selectedTab = 0; // 0 = App detail, 1 = Billing history

  AppDetailsParam get param => widget.param;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.onPrimary,
            foregroundColor: AppColors.onSecondary,
          ),
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "App Detail",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // App Icon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.onPrimaryLight,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(18),
                    child: Image.memory(
                      base64Decode(param.icon),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // App Name
                  Text(
                    param.appName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      param.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                        color: AppColors.subtitleTextColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tab Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TabButton(
                          title: "App detail",
                          isSelected: _selectedTab == 0,
                          onTap: () => setState(() => _selectedTab = 0),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TabButton(
                          title: "Billing history",
                          isSelected: _selectedTab == 1,
                          onTap: () => setState(() => _selectedTab = 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Content based on tab
                  if (_selectedTab == 0) _buildAppDetailContent(context),
                  if (_selectedTab == 1) _buildBillingHistoryContent(context),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Handle edit
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text("Edit"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Handle unsubscribe
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        foregroundColor: AppColors.onSurfaceLight,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: Text(
                        param.isSubscribed ? "Unsubscribed" : "Subscribe",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppDetailContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          DetailRow(label: "App Name :", value: param.appName),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerLight,
            indent: 20,
            endIndent: 20,
          ),
          DetailRow(label: "App category :", value: param.appCategory),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerLight,
            indent: 20,
            endIndent: 20,
          ),
          DetailRow(
            label: "Subscription Date :",
            value: param.subscriptionDate,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerLight,
            indent: 20,
            endIndent: 20,
          ),
          DetailRow(label: "Payment cycle :", value: param.paymentCycle),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerLight,
            indent: 20,
            endIndent: 20,
          ),
          DetailRow(
            label: "Subscription Cost :",
            value: "\$${param.subscriptionCost.toStringAsFixed(2)}",
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerLight,
            indent: 20,
            endIndent: 20,
          ),
          DetailRow(label: "Remind me :", value: param.remindMe),
        ],
      ),
    );
  }

  Widget _buildBillingHistoryContent(BuildContext context) {
    if (param.billingHistory.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            "No billing history yet",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ),
      );
    }

    return Column(
      children: param.billingHistory.map((entry) {
        return BillingHistoryTile(
          icon: param.icon,
          month: entry.month,
          date: entry.date,
          amount: entry.amount,
        );
      }).toList(),
    );
  }
}
