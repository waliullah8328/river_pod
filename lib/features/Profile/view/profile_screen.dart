import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/language/custom_localized_text.dart';
import 'package:river_pod/core/services/auth_service.dart';
import 'package:river_pod/core/utils/constants/image_path.dart';
import '../../../core/language/app_local.dart';
import '../../../core/language/local_notifier_widget.dart';
import '../view_model/profile_view_model.dart';
// your themeModeProvider

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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

    final state = ref.watch(profileNotifierProvider);
    final notifier = ref.read(profileNotifierProvider.notifier);
    final localeNotifier = ref.read(localeProvider.notifier);
    final currentLocale = ref.watch(localeProvider);
    final currentLangCode = currentLocale.languageCode;

    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: CustomLocalizedText(AppLocale.profileAppBarText),
        centerTitle: true,
        elevation: 0,
        //backgroundColor: theme.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: themeMode == ThemeMode.light
                  ?Colors.black:Colors.white,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              backgroundImage: const AssetImage(ImagePath.onBoardingImage),
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              _getText(AppLocale.hello, currentLangCode),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            // Welcome Text
            Text(
              _getText(AppLocale.welcome, currentLangCode),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),

            // Card with Language Selector
            Card(
              elevation: 3,
              color: theme.cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getText('Select Language', currentLangCode),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DropdownButton<String>(
                      value: currentLangCode,
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(12),
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(value: 'km', child: Text('ខ្មែរ')),
                        DropdownMenuItem(value: 'bn', child: Text('বাংলা')),
                      ],
                      onChanged: (value) {
                        if (value != null) localeNotifier.changeLocale(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Notifications switch (Animated)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Notifications"),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Switch.adaptive(
                    key: ValueKey(state.notifications),
                    value: state.notifications,
                    onChanged: notifier.setNotifications,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Info Cards
            _infoCard(
              icon: Icons.email_outlined,
              title: _getText('Email', currentLangCode),
              subtitle: 'user@example.com',
              theme: theme,
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.phone_android_outlined,
              title: _getText('Phone', currentLangCode),
              subtitle: '+880 1234 567890',
              theme: theme,
            ),
            const SizedBox(height: 12),
            _infoCard(
              icon: Icons.location_on_outlined,
              title: _getText('Location', currentLangCode),
              subtitle: 'Dhaka, Bangladesh',
              theme: theme,
            ),

            const SizedBox(height: 32),

            // Logout button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                AuthService.logoutUser(context);
              },
              icon: const Icon(Icons.logout),
              label: Text(
                _getText('Logout', currentLangCode),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required ThemeData theme,
  }) {
    return Card(
      elevation: 2,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.primaryColor.withOpacity(0.1),
          child: Icon(icon, color: theme.primaryColor),
        ),
        title: Text(title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
