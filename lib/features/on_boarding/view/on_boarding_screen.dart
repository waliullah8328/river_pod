
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/language/custom_localized_text.dart';

import 'package:river_pod/core/utils/constants/app_sizer.dart';
import 'package:river_pod/features/on_boarding/view/widgets/on_boarding_buider.dart';
import 'package:river_pod/route/routes_name.dart';

import '../../../core/language/app_local.dart';
import '../view_model/on_boarding_view_model.dart';


class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: OnboardingBuilder()),
          Positioned(
            right: 20.w,
            child: SafeArea(
              child: TextButton(
                onPressed: () {
                  // Skip functionality will be there
                 // Get.toNamed(EmailSignUpScreen.routeName);

                  Navigator.pushNamed(context, RouteNames.loginScreen );
                },
                child:CustomLocalizedText(AppLocale.onBoardingSkipButton),
              ),
            ),
          ),

          Positioned(
            bottom: 40.h,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: List.generate(
                  3,
                      (index) => Container(
                    height: 4.h,
                    width: MediaQuery.of(context).size.width * 0.12,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color:
                      onboardingState.currentIndex == index
                          ? const Color(0xFF111A49)
                          : const Color(0xFFEDEEF5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}