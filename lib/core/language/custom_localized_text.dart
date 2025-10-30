import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/language/app_local.dart';
import '../../core/language/local_notifier_widget.dart';

/// Custom widget to display localized text
class CustomLocalizedText extends ConsumerWidget {
  final String keyName;
  final TextStyle? style;
  final TextAlign? textAlign;

  const CustomLocalizedText(
      this.keyName, {
        super.key,
        this.style,
        this.textAlign,
      });

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
    final currentLangCode = ref.watch(localeProvider).languageCode;
    return Text(
      _getText(keyName, currentLangCode),
      style: style,
      textAlign: textAlign,
    );
  }
}
