

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/features/on_boarding/view/widgets/page_builder.dart';

import '../../view_model/on_boarding_view_model.dart';

class OnboardingBuilder extends ConsumerWidget {
  const OnboardingBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    final onboardingController = ref.read(
      onboardingControllerProvider.notifier,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.4, 0.6, 1.0],
          colors: const [
            Colors.white,
            Colors.white,
            Color(0xFFBB0AF9),
            Color(0xFF7124FF),
          ],
        ),
      ),
      child: PageView(
        controller: onboardingState.pageController,
        onPageChanged:
            (value) => onboardingController.updateCurrentIndex(value),
        children: [
          PageBuilders(pageNumber: 0),
          PageBuilders(pageNumber: 1),
          PageBuilders(pageNumber: 2),
        ],
      ),
    );
  }
}