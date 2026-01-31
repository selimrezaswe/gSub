import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/cubit/app_bottom_nav_cubit.dart';
import 'package:subscription_manager/features/app_bottom_nav/presentation/pages/app_bottom_nav.dart';
import 'package:subscription_manager/injection_container.dart' as di;
import 'package:subscription_manager/main.dart';

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
final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return BlocProvider(
            create: (context) => di.sl<AppBottomNavCubit>(),
            child: const AppBottomNav(),
          );
      },
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: BlocProvider(
            create: (context) => di.sl<AppBottomNavCubit>(),
            child: const AppBottomNav(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
   
  ],
);