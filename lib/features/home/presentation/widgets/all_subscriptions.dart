import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/core/constant/demo.dart';
import 'package:subscription_manager/features/app_details/domain/entities/app_details_param.dart';
import 'package:subscription_manager/features/home/presentation/widgets/all_subscriptions_card_widget.dart';

class AllSubscriptions extends StatelessWidget {
  const AllSubscriptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Row(
                spacing: 8,
                children: [
                  Text(
                    "All Subscriptions",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(99),
                      color: AppColors.yellow,
                    ),
                    child: Text(
                      "10",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  context.go(AppRoutes.plans);
                },
                child: Text("See All"),
              ),
            ],
          ),
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 15),
          shrinkWrap: true,
          itemBuilder: (context, index) => AllSubscriptionsCardWidget(
            onTap: () {
              context.push(
                AppRoutes.appDetails,
                extra: AppDetailsParam(
                  billingHistory: [
                    BillingEntry(
                      month: 'January',
                      date: '12.01.2025',
                      amount: 12.00,
                    ),
                    BillingEntry(
                      month: 'February',
                      date: '12.02.2025',
                      amount: 12.00,
                    ),
                  ],
                  appName: 'Microsoft Copilot',
                  appCategory: 'Productivity',
                  subscriptionDate: '12.12.2025',
                  paymentCycle: 'Monthly',
                  subscriptionCost: 10.00,
                  remindMe: '2 days before billing date',
                  icon: demoImageBase64,
                  description:
                      'Microsoft Copilot is an innovative tool designed to enhance productivity by integrating AI capabilities',
                ),
              );
            },
          ),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: 10,
        ),
      ],
    );
  }
}
