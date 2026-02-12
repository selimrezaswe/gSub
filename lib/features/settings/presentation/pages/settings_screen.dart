import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/features/settings/presentation/widget/select_currency.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;
  bool _syncEnabled = true;

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
          onPressed: () {
            context.go(AppRoutes.home);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
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
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.onPrimaryLight,
                    child: Icon(
                      Icons.person,
                      size: 28,
                      color: AppColors.onSecondary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    "Bappy Mithun",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Navigation Section
            _buildSectionHeader("Navigation"),
            const SizedBox(height: 8),
            _buildNavItem(
              title: "All Subscription",
              onTap: () {
                context.go(AppRoutes.plans);
              },
            ),
            _buildNavItem(
              title: "Category",
              onTap: () {
                context.push(AppRoutes.allCategory);
              },
            ),
            _buildNavItem(
              title: "Reports",
              onTap: () {
                context.go(AppRoutes.report);
              },
            ),

            const SizedBox(height: 15),

            // Setting & Other Section
            _buildSectionHeader("Setting & Other"),
            const SizedBox(height: 8),
            _buildNavItem(
              title: "Currency",
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height*0.8,
                    minHeight: MediaQuery.of(context).size.height*0.6,
                  ),
                  backgroundColor: Color(0xffEFF3F6),
                  showDragHandle: true,
                  context: context,
                  builder: (context) => SelectCurrency(),
                );
              },
            ),
            _buildNavItem(
              title: "Language",
              onTap: () {},
            ),
            // _buildNavItem(
            //   title: "App Lock",
            //   onTap: () {},
            // ),

            // const SizedBox(height: 8),

            // Notifications Toggle
            _buildToggleItem(
              title: "Notifications",
              value: _notificationsEnabled,
              onChanged: (val) {
                setState(() => _notificationsEnabled = val);
              },
            ),

            // Sync Toggle
            _buildToggleItem(
              title: "Sync",
              value: _syncEnabled,
              onChanged: (val) {
                setState(() => _syncEnabled = val);
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.onSecondary.withOpacity(0.6),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.onSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.onPrimary,
              activeTrackColor: AppColors.primary,
              inactiveThumbColor: AppColors.onPrimary,
              inactiveTrackColor: AppColors.onSecondary.withOpacity(0.3),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}
