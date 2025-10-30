import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/language/app_local.dart';
import 'package:river_pod/core/language/custom_localized_text.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';
import 'package:river_pod/route/routes_name.dart';
import '../../core/language/local_notifier_widget.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeNotifier = ref.read(localeProvider.notifier);
    final currentLocale = ref.watch(localeProvider);
    final currentLangCode = currentLocale.languageCode;

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  CustomLocalizedText(AppLocale.selectLanguage,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),),

                  SizedBox(height: 10),
                  CustomLocalizedText(AppLocale.choseLanguage,
                    style: TextStyle(
                      fontSize: 16.sp,

                    ),textAlign: TextAlign.center,),

                ],
              ),
            ),
            const SizedBox(height: 50),

            // Language cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    LanguageCard(
                      title: 'English',
                      icon: Icons.language,
                      isSelected: currentLangCode == 'en',
                      onTap: () => localeNotifier.changeLocale('en'),
                    ),
                    const SizedBox(height: 20),
                    LanguageCard(
                      title: 'មែរ',
                      icon: Icons.translate,
                      isSelected: currentLangCode == 'km',
                      onTap: () => localeNotifier.changeLocale('km'),
                    ),
                    const SizedBox(height: 20),
                    LanguageCard(
                      title: 'বাংলা',
                      icon: Icons.translate,
                      isSelected: currentLangCode == 'bn',
                      onTap: () => localeNotifier.changeLocale('bn'),
                    ),
                  ],
                ),
              ),
            ),

            // Continue button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RouteNames.onboardingScreen);
                  },
                  child:CustomLocalizedText(AppLocale.continueButtonText,style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

/// Language selection card widget
class LanguageCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
              width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade200,
              child: Icon(icon,
                  color: isSelected ? Colors.white : Colors.grey.shade700),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blueAccent : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
