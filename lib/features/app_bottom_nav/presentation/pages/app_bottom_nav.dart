import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/cubit/app_bottom_nav_cubit.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/cubit/app_bottom_nav_state.dart';
import 'package:subscription_manager/features/home/presentation/pages/home_screen.dart';
import 'package:subscription_manager/features/menu/presentation/pages/menu_screen.dart';
import 'package:subscription_manager/features/orders/presentation/pages/orders_screen.dart';
import 'package:subscription_manager/features/reports/presentation/pages/report_screen.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavCubit, AppBottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: const [
              MenuScreen(),
              OrdersScreen(),
              HomeScreen(),
              ReportScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            onTap: (value) {
              context.read<AppBottomNavCubit>().changeIndex(value);
            },
            iconSize: 0,
            currentIndex: state.selectedIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,

            items: [
              bottomNavBarItem(
                context,
                icondata: Icons.menu,
                title: "Menu",
              ),
              bottomNavBarItem(
                context,
                icondata: Icons.note_add,
                title: "Orders",
              ),
              bottomNavBarItem(
                context,
                icondata: Icons.home,
                title: "Home",
              ),
              bottomNavBarItem(
                context,
                icondata: Icons.bar_chart,
                title: "Report",
              ),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavBarItem(
    BuildContext context, {
    required IconData icondata,
    required String title,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: AppColors.primary,
      activeIcon: Container(
        width: 72,
        height: 55,

        // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(80),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 3,
          children: [
            Icon(
              icondata,
              size: 25,
              color: Colors.white,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 3,
        children: [
          Icon(
            icondata,
            size: 25,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
      label: title,
    );
  }
}
