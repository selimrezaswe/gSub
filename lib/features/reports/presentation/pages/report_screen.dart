import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/reports/domain/entities/report_bar_entry.dart';
import 'package:subscription_manager/features/reports/presentation/widget/bar_chart_widget.dart';
import 'package:subscription_manager/features/reports/presentation/widget/category_spend_card.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final entries = [
      const ReportBarEntry(value: 620, label: 'Music'),
      const ReportBarEntry(value: 480, label: 'Games'),
      const ReportBarEntry(value: 780, label: 'Cloud'),
      const ReportBarEntry(value: 1200, label: 'Entertainment'),
      const ReportBarEntry(value: 860, label: 'Design'),
      const ReportBarEntry(value: 940, label: 'Streaming'),
      const ReportBarEntry(value: 720, label: 'Work'),
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
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Reports",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BarChartWidget(entries: entries),

              const SizedBox(height: 16),
              ...entries.map(
                (entry) => CategorySpendCard(
                  label: entry.label,
                  amount: entry.value,
                  yearlyEstimate: entry.value * 12,
                  maxAmount: entries
                      .map((e) => e.value)
                      .reduce((a, b) => a > b ? a : b),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
