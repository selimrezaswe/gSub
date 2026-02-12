import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/pages/app_bottom_nav.dart';
import 'package:subscription_manager/features/category/domain/entities/category.dart';
import 'package:subscription_manager/features/category/presentation/pages/category_screen.dart';
import 'package:subscription_manager/features/app_details/domain/entities/app_details_param.dart';
import 'package:subscription_manager/features/app_details/presentation/pages/app_detail_screen.dart';
import 'package:subscription_manager/features/category/presentation/pages/crud_category.dart';
import 'package:subscription_manager/features/home/presentation/pages/home_screen.dart';
import 'package:subscription_manager/features/notifications/presentation/pages/notifications.dart';
import 'package:subscription_manager/features/onboard/presentation/pages/onboarding_screen.dart';
import 'package:subscription_manager/features/onboard/presentation/pages/sync_page.dart';
import 'package:subscription_manager/features/onboard/presentation/pages/user_setup.dart';
import 'package:subscription_manager/features/plans/domain/entites/plan.dart';
import 'package:subscription_manager/features/plans/presentation/pages/crud_plan.dart';
import 'package:subscription_manager/features/settings/presentation/pages/settings_screen.dart';
import 'package:subscription_manager/features/plans/presentation/pages/plan_screen.dart';
import 'package:subscription_manager/features/reports/presentation/pages/report_screen.dart';
import 'package:subscription_manager/features/splash_screen/presentation/pages/splash.dart';
import 'package:subscription_manager/main.dart';
import 'package:subscription_manager/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/features/plans/presentation/cubit/tab_cubit.dart';

// /// Redirects to onboarding when not yet completed. Onboarding is shown only once.
// Future<String?> _onboardingRedirect(BuildContext context, GoRouterState state) async {
//   final path = state.uri.path;
//   if (path == '/onboarding') return null;

//   final storage = di.sl<LocalStorage>();
//   final completed = storage.getOrDefault<bool>(StorageKeys.onboardingCompleted, false);
//   if (!completed) return '/onboarding';
//   return null;
// }

/// Application router configuration using go_router
///
/// This file defines all routes in the application.
/// Routes are organized by feature and support deep linking.

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String plans = '/plans';
  static const String report = '/report';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String appDetails = '/app-details';
  static const String allCategory = '/all-category';
  static const String addCategory = '/addcategory';
  static const String editCategory = '/editcategory';
  static const String onboarding = '/newuser';
  static const String userSetup = '/user-setup';
  static const String syncPage = '/sync-page';
  static const String editPlan = '/edit-plan';
  static const String addPlan = '/add-plan';
}

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Splash(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppBottomNav(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) =>
                  CustomTransitionPage(
                    child: const HomeScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.plans,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: BlocProvider<TabCubit>(
                  create: (_) => di.sl<TabCubit>(),
                  child: const PlansScreen(),
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.report,
              pageBuilder: (context, state) =>
                  CustomTransitionPage(
                    child: const ReportScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              pageBuilder: (context, state) =>
                  CustomTransitionPage(
                    child: const SettingsScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                  ),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: AppRoutes.notifications,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotificationsScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.allCategory,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AllCategoryScreen(),
      ),
    ),

    GoRoute(
      path: AppRoutes.appDetails,
      pageBuilder: (context, state) {
        final param = state.extra as AppDetailsParam;
        return NoTransitionPage(child: AppDetailScreen(param: param));
      },
    ),
    GoRoute(
      path: AppRoutes.addCategory,
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: CrudCategory(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editCategory,
      pageBuilder: (context, state) {
        final data = state.extra as Category;
        return NoTransitionPage(
          child: CrudCategory(
            data: data,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.userSetup,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: UserSetup(),
      ),
    ),
    GoRoute(
      path: AppRoutes.syncPage,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SyncPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.editPlan,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: CrudPlanScreen(
          plan: state.extra as Plan,
        ),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          ),
      ),
    ),
    GoRoute(
      path: AppRoutes.addPlan,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const CrudPlanScreen(),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          ),
      ),
    ),
  ],
);
