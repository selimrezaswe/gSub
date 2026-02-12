import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subscription_manager/core/constant/app_assets.dart';
import 'package:subscription_manager/features/onboard/domain/entites/pageview_element.dart';
import 'package:subscription_manager/features/onboard/presentation/cubits/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
    : super(
        OnboardingState(
          pageViewElements: [
            PageViewElement(
              title: 'Get Started',
              description:
                  'Take the first step on your journey to better mental health. Get started today!',
              image: AppAssets.images.object2,
            ),
            PageViewElement(
              title: 'Never Miss a Payment',
              description:
                  'If you think that you or someone you know has a mental health problem, there are a number of ways that you can seek advice.',
              image: AppAssets.images.object3,
            ),
            PageViewElement(
              title: 'Track All Subscriptions',
              description:
                  'Transforming lives by offering hope and opportunities for recovery, wellness, and independence.',
              image: AppAssets.images.object1,
            ),
          ],
          currentPage: 0,
          pageController: PageController(initialPage: 0),
        ),
      );

  void setCurrentPage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  
  Timer? _timer;
  void rotatePage() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
    state.pageController?.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
