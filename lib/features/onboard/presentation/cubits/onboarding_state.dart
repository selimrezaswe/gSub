import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:subscription_manager/features/onboard/domain/entites/pageview_element.dart';

class OnboardingState extends Equatable {
  final List<PageViewElement> pageViewElements;
  final int currentPage;

  final PageController? pageController;
  
  const OnboardingState({
    required this.pageViewElements,
    required this.currentPage, required this.pageController,
  });

  @override
  List<Object?> get props => [pageViewElements, currentPage, pageController];

  OnboardingState copyWith({
    List<PageViewElement>? pageViewElements,
    PageViewElement? currentPageViewElement,
    int? currentPage,
    PageController? pageController,
  }) {
    return OnboardingState(
      pageViewElements: pageViewElements ?? this.pageViewElements,
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController ?? this.pageController,
    );
  }
}