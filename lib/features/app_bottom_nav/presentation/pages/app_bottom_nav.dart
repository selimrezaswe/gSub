import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isSettingsSelected = navigationShell.currentIndex == 3;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: isSettingsSelected ? null : ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            navigationShell.goBranch(
              value,
              initialLocation: value == navigationShell.currentIndex,
            );
          },
          iconSize: 0,
          currentIndex: navigationShell.currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            bottomNavBarItem(
              context,
              icondata: HugeIcons.strokeRoundedHome03,
              title: "Home",
            ),
            bottomNavBarItem(
              context,
              icondata: Iconsax.heart,
              title: "Plans",
            ),
            bottomNavBarItem(
              context,
              icondata: Iconsax.chart_15,
              title: "Report",
            ),
            bottomNavBarItem(
              context,
              icondata: Iconsax.menu_1,
              title: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem bottomNavBarItem(
    BuildContext context, {
    required dynamic icondata,
    required String title,
  }) {
    return BottomNavigationBarItem(
      backgroundColor: AppColors.primary,
      activeIcon: Container(
        // margin: EdgeInsets.symmetric(horizontal: 5),
        width: 85,
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
            if (icondata is IconData)
              Icon(
                icondata,
                size: 25,
                color: Colors.white,
              )
            else if (icondata is List<List<dynamic>>)
              HugeIcon(
                icon: icondata,
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
          if (icondata is IconData)
            Icon(
              icondata,
              size: 25,
              // color: Colors.white,
            )
          else if (icondata is List<List<dynamic>>)
            HugeIcon(
              icon: icondata,
              size: 25,
              // color: Colors.white,
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
