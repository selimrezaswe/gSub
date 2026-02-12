import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_manager/app/app_route.dart';
import 'package:subscription_manager/core/constant/app_colors.dart';
import 'package:subscription_manager/features/onboard/presentation/cubits/onboarding_cubit.dart';
import 'package:subscription_manager/features/onboard/presentation/cubits/onboarding_state.dart';
import 'package:subscription_manager/features/onboard/presentation/widgets/blur_back_ground.dart';
import 'package:subscription_manager/features/onboard/presentation/widgets/custom_page_view_element.dart';
import 'package:subscription_manager/injection_container.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fromHex("#A5B4FC"),
      body: BlurBackGround(
        child: BlocProvider(
          create: (context) => sl<OnboardingCubit>(),
          child: const _OnboardingContent(),
        ),
      ),
    );
  }
}

class _OnboardingContent extends StatefulWidget {
  const _OnboardingContent();

  @override
  State<_OnboardingContent> createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<_OnboardingContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<OnboardingCubit>().rotatePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocSelector<OnboardingCubit, OnboardingState, int>(
              selector: (state) => state.currentPage,
              builder: (context, currentPage) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    spacing: 5,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: index == currentPage ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentPage
                              ? AppColors.primary
                              : AppColors.primaryVariant.withAlpha(120),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onBackgroundLight,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
        ),
        Expanded(
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return PageView.builder(
                controller: state.pageController,
                // itemCount: state.pageViewElements.length,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().setCurrentPage(index%state.pageViewElements.length);
                },
                itemBuilder: (context, index) {
                  final element = state.pageViewElements[index%state.pageViewElements.length];
                  return CustomPageViewElement(
                    title: element.title,
                    description: element.description,
                    image: element.image,
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 10,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onPrimary,
                  ),
                ),
                onPressed: () {
                  context.push(AppRoutes.userSetup);
                },
                child: Text("Get Started"),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.onBackgroundDark,
                  foregroundColor: AppColors.onBackgroundLight,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppColors.primary, width: 1),
                  ),
                ),
                onPressed: () {
                  context.push(AppRoutes.syncPage);
                },
                child: Text("Restore"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
