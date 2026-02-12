import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_assets.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/onboard/presentation/widgets/blur_back_ground.dart';
import 'package:subscription_manager/features/splash_screen/presentation/cubit/splash_cubit.dart';
import 'package:subscription_manager/features/splash_screen/presentation/cubit/splash_state.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnboarding) {
            context.go(AppRoutes.onboarding);
          }
        },
        child: Scaffold(
           backgroundColor: AppColors.fromHex("#A5B4FC"),
          body: BlurBackGround(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppAssets.images.logo, height: 170, width: 152),
                // SizedBox(height: 5),
                Text(
                  "G-SUBS",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onBackgroundDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
