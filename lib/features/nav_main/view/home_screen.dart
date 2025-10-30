import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/language/app_local.dart';
import '../../../core/language/local_notifier_widget.dart';


import '../../Profile/view/profile_screen.dart';

// Provider for bottom navigation index
final currentIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen1 extends ConsumerWidget {
  const HomeScreen1({super.key});

  String _getText(String key, String langCode) {
    switch (langCode) {
      case 'km':
        return AppLocale.kn[key] ?? key;
      case 'bn':
        return AppLocale.bn[key] ?? key;
      case 'en':
      default:
        return AppLocale.en[key] ?? key;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeNotifier = ref.read(localeProvider.notifier);
    final currentLocale = ref.watch(localeProvider);
    final currentLangCode = currentLocale.languageCode;

    final currentIndex = ref.watch(currentIndexProvider);

    final List<Widget> pages = [
      const Center(child: Text('Home Page Content')),
      const Center(child: Text('Profile Page Content')),
      const ProfileScreen(),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const CustomLocalizedText(
      //     AppLocale.home,
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.notifier).state = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: _getText(AppLocale.home, currentLangCode),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: _getText(AppLocale.profile, currentLangCode),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: _getText(AppLocale.settings, currentLangCode),
          ),
        ],
      ),
    );
  }
}
