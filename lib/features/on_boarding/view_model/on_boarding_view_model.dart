import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController() : super(OnboardingState()) {
    // Keep same controller instance
    state = state.copyWith(pageController: PageController());
  }

  void updateCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void nextPage() {
    final controller = state.pageController;
    if (controller.hasClients && state.currentIndex < 2) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPage(int page) {
    final controller = state.pageController;
    if (controller.hasClients && page >= 0 && page <= 2) {
      controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}

class OnboardingState {
  final int currentIndex;
  final PageController pageController;

  OnboardingState({
    this.currentIndex = 0,
    PageController? pageController,
  }) : pageController = pageController ?? PageController();

  OnboardingState copyWith({
    int? currentIndex,
    PageController? pageController,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      pageController: pageController ?? this.pageController,
    );
  }
}

final onboardingControllerProvider =
StateNotifierProvider<OnboardingController, OnboardingState>(
      (ref) => OnboardingController(),
);
