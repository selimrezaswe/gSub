import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/home/presentation/widgets/all_subscriptions_card_widget.dart';
import 'package:subscription_manager/features/plans/presentation/cubit/tab_cubit.dart';
import 'package:subscription_manager/features/plans/presentation/cubit/tab_state.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

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
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "All Plans",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 25),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 5,
              children: PlanTab.values
                  .map(
                    (e) => BlocBuilder<TabCubit, TabState>(
                      builder: (context, state) {
                        return TabPill(
                          title: e.name,
                          isActive: e == state.selectedTab,
                          onTap: () {
                            context.read<TabCubit>().setSelectedTab(e);
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        // spacing: 10,
        children: [
          Expanded(
            child: Scaffold(
              body: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 20,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
                itemBuilder: (context, index) {
                  return AllSubscriptionsCardWidget(
                    withOptions: true,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabPill extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  const TabPill({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),

      onTap: onTap,
      child: Container(
        height: 35,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.onPrimary,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isActive ? AppColors.onPrimary : AppColors.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
