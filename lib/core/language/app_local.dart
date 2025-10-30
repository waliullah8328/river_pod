import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../language/local_notifier_widget.dart'; // Your locale provider

/// Localization keys
mixin AppLocale {
  static const String hello = 'hello';
  static const String welcome = 'welcome';
  static const String home = 'home';
  static const String profile = 'profile';
  static const String settings = 'settings';

  // Language Screen
  static const String selectLanguage = "Select Your Language";
  static const String choseLanguage = 'Choose your preferred language to continue using the app';
  static const String continueButtonText = 'Continue';


  // Onboarding screen
  static const String onBoardingSkipButton = 'Skip';
  static const String onBoardingWelcome = 'Welcome to Your Smart \nReading Companion';
  static const String onBoardingWelcome2 = 'Thousands of Books at \nYour Fingertips';
  static const String onBoardingWelcome3 = "Save Your Favorites and \nPick Up Where You Left";
  static const String onBoardingDescription1 = "Discover books, read online, and unlock \nexclusive rewards  all in one place";
  static const String onBoardingDescription2 = "Browse by genre, search by title, and enjoy \nin-app reading with ease.";
  static const String onBoardingDescription3 = "Bookmark pages, mark favorites, and never \nlose your place again.";
  static const String getStartedButtonText = "Get Started";

  // For Login Screen
  static const String loginAppBarText = 'Login Screen';
  static const String emailHintText = 'Email';
  static const String passwordHintText = 'Password';
  static const String submitButtonText = 'Submit';

  // Profile Screen
  static const String profileAppBarText = 'Profile Screen';

  // English
  static const Map<String, String> en = {
    hello: 'Hello!',
    welcome: 'Welcome to Flutter Localization!',
    home: 'Home',
    profile: 'Profile',
    settings: 'Settings',
    selectLanguage : "Select Your Language",
    choseLanguage : 'Choose your preferred language to continue using the app' ,
    continueButtonText : 'Continue',
    onBoardingSkipButton:"Skip",
    onBoardingWelcome:"Welcome to Your Smart \nReading Companion",
    onBoardingWelcome2 : 'Thousands of Books at \nYour Fingertips',
    onBoardingWelcome3 : "Save Your Favorites and \nPick Up Where You Left",
    onBoardingDescription1 :"Discover books, read online, and unlock \nexclusive rewards  all in one place",
    onBoardingDescription2 : "Browse by genre, search by title, and enjoy \nin-app reading with ease.",
    onBoardingDescription3 : "Bookmark pages, mark favorites, and never \nlose your place again.",
    getStartedButtonText : "Get Started" ,
    loginAppBarText:'Login Screen',
    emailHintText : 'Email',
    passwordHintText : 'Password',
    submitButtonText : 'Submit',
    profileAppBarText :'Profile Screen',
  };

  // Khmer
  static const Map<String, String> kn = {
    hello: 'សួស្តី!',
    welcome: 'សូមស្វាគមន៍មកកាន់ Flutter Localization!',
    home: 'ទំព័រដើម',
    profile: 'ប្រវត្តិរូប',
    settings: 'ការកំណត់',
    choseLanguage : 'ជ្រើសរើសភាសាដែលអ្នកពេញចិត្ត ដើម្បីបន្តប្រើប្រាស់កម្មវិធី',
    selectLanguage : "ជ្រើសរើសភាសារបស់អ្នក",
    continueButtonText : 'បន្ត',
    onBoardingSkipButton:"រំលង",
    onBoardingWelcome:"សូមស្វាគមន៍មកកាន់ របស់អ្នក \nដៃគូអាន",
    onBoardingWelcome2 : 'សៀវភៅរាប់ពាន់ក្បាលនៅ \nចុងម្រាមដៃរបស់អ្នក',
    onBoardingWelcome3 : "រក្សាទុក​ចំណូលចិត្ត​របស់អ្នក និង \nទទួលយកកន្លែងដែលអ្នកចាកចេញ",
    onBoardingDescription1 :"ស្វែងរកសៀវភៅ អានតាមអ៊ីនធឺណិត និងដោះសោ \nរង្វាន់ផ្តាច់មុខទាំងអស់នៅកន្លែងតែមួយ",
    onBoardingDescription2 : "រកមើលតាមប្រភេទ ស្វែងរកតាមចំណងជើង ហើយរីករាយ \nការអានក្នុងកម្មវិធីដោយភាពងាយស្រួល។",
    onBoardingDescription3 : "ចំណាំទំព័រ សម្គាល់ចំណូលចិត្ត ហើយកុំ \nបាត់បង់កន្លែងរបស់អ្នកម្តងទៀត។" ,
    getStartedButtonText : "ចាប់ផ្តើម" ,
    loginAppBarText:'អេក្រង់ចូល',
    emailHintText:'អ៊ីមែល',
    passwordHintText : 'ពាក្យសម្ងាត់',
    submitButtonText:'ដាក់ស្នើ',
    profileAppBarText :"프로필 화면",
  };

  // Bangla
  static const Map<String, String> bn = {
    hello: 'হ্যালো!',
    welcome: 'ফ্লাটার লোকালাইজেশনে স্বাগতম!',
    home: 'হোম',
    profile: 'প্রোফাইল',
    settings: 'সেটিংস',
    choseLanguage : 'অ্যাপটি ব্যবহার চালিয়ে যেতে আপনার পছন্দের ভাষা বেছে নিন',
    selectLanguage : "আপনার ভাষা নির্বাচন করুন",
    continueButtonText : 'চালিয়ে যান',
    onBoardingSkipButton:"এড়িয়ে যান",
    onBoardingWelcome:"আপনার স্মার্ট \nরিডিং কম্প্যানিয়নে স্বাগতম",
    onBoardingWelcome2 : 'হাজার হাজার বই \nতোমার আঙুলের ডগায়',
    onBoardingWelcome3 : "আপনার পছন্দের জিনিসগুলি সংরক্ষণ \nকরুন এবং যেখান থেকে রেখেছিলে \nসেখান থেকে তুলে নাও",
    onBoardingDescription1 :"বই আবিষ্কার করুন, অনলাইনে পড়ুন এবং আনলক করুন \nএকচেটিয়া পুরষ্কার সব এক জায়গায়",
    onBoardingDescription2 : "ধরণ অনুসারে ব্রাউজ করুন, শিরোনাম অনুসারে অনুসন্ধান করুন \nএবং উপভোগ করুনসহজেই অ্যাপ-মধ্যস্থ পঠন।",
    onBoardingDescription3 : "পৃষ্ঠাগুলি বুকমার্ক করুন, পছন্দসই চিহ্নিত করুন, এবং কখনও না \nআবার তোমার জায়গা হারিয়ে ফেলো।" ,
    getStartedButtonText : "শুরু করুন" ,
    loginAppBarText: 'লগইন স্ক্রিন',
    emailHintText:"ইমেইল",
    passwordHintText : 'পাসওয়ার্ড',
    submitButtonText:'জমা দিন',
    profileAppBarText:"প্রোফাইল স্ক্রিন",
  };
}

/// Extension to get localized string based on current locale
extension AppLocaleExt on String {
  String getString(BuildContext context) {
    Locale currentLocale = context.readLocale(); // get current locale from Riverpod
    switch (currentLocale.languageCode) {
      case 'km':
        return AppLocale.kn[this] ?? this;
      case 'bn':
        return AppLocale.bn[this] ?? this;
      case 'en':
      default:
        return AppLocale.en[this] ?? this;
    }
  }
}

/// Helper extension to get current locale from BuildContext using Riverpod
extension LocaleContextExtension on BuildContext {
  Locale readLocale() {
    try {
      // Try to read the locale from the provider
      final container = ProviderScope.containerOf(this);
      final locale = container.read(localeProvider);
      return locale ;
    } catch (_) {
      return const Locale('en');
    }
  }
}
