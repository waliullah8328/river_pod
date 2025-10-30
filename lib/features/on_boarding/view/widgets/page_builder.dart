import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/language/app_local.dart';
import 'package:river_pod/core/language/custom_localized_text.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';
import 'package:river_pod/route/routes_name.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/constants/image_path.dart';
import '../../view_model/on_boarding_view_model.dart';
import 'get_started_button.dart';
import 'on_forward_button.dart';

class PageBuilders extends ConsumerWidget {
  const PageBuilders({super.key, required this.pageNumber});
  final int pageNumber;

  static  List<String> onboardingImages = [
    ImagePath.onBoardingImage1,
    ImagePath.onBoardingImage2,
    ImagePath.onBoardingImage3,
  ];

  static const List<String> titles = <String>[
    AppLocale.onBoardingWelcome,
    AppLocale.onBoardingWelcome2,
    AppLocale.onBoardingWelcome3,
  ];
  static const List<String> descriptions = <String>[
    AppLocale.onBoardingDescription1,
    AppLocale.onBoardingDescription2,
    AppLocale.onBoardingDescription3,

  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    // final onboardingController = ref.read(
    //   onboardingControllerProvider.notifier,
    // );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onboardingImages[pageNumber]),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                children: [
                  CustomLocalizedText(titles[pageNumber],style: TextStyle(

                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,

                  ),textAlign: TextAlign.center,),

                  SizedBox(height: 12.h),
                  CustomLocalizedText(descriptions[pageNumber],style: TextStyle(

                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,

                  ),textAlign: TextAlign.center,),

                ],
              ),
            ),
            onboardingState.currentIndex < 2
                ? OnbForwardButton(
              onTap: () {
                log("Forward button called");
                ref.read(onboardingControllerProvider.notifier).nextPage();
              },
            )
                : GetStartedButton(
              onTap: () async {
                await AuthService.setOnboardingSeen(true);
                //Get.offAllNamed(EmailSignUpScreen.routeName);
                Navigator.pushNamed(context, RouteNames.loginScreen);
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}