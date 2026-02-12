import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'name': 'Microsoft Co-pilot',
        'daysRemaining': '2 days',
        'description': 'remaining for payment. Your Monthly Subscription fee is',
        'amount': '\$12.00',
      },
      {
        'name': 'Microsoft Co-pilot',
        'daysRemaining': '2 days',
        'description': 'remaining for payment. Your Monthly Subscription fee is',
        'amount': '\$12.00',
      },
    ];

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
          "Reminder Notifications",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          // Subtitle
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "When you have done your payment, then come here and press on the payment done button.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: AppColors.subtitleTextColor,
                    height: 1.5,
                  ),
            ),
          ),

          // Notification Cards
          ...List.generate(notifications.length, (index) {
            final item = notifications[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.onPrimaryLight,
                    child: Icon(
                      Icons.subscriptions_outlined,
                      size: 20,
                      color: AppColors.onSecondary,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name']!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: item['daysRemaining']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ' ${item['description']!} ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.subtitleTextColor,
                                ),
                              ),
                              TextSpan(
                                text: item['amount']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.onSurfaceLight,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: const Text("Payment done"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
