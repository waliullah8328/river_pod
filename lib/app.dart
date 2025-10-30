import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:river_pod/route/routes.dart';
import 'package:river_pod/route/routes_name.dart';

import 'core/utils/constants/app_sizer.dart';
import 'core/utils/constants/app_sizes.dart';
import 'core/utils/theme/theme.dart';

import 'features/Profile/view_model/profile_view_model.dart';

class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppSizes().init(context);

    final themeMode = ref.watch(themeModeProvider); // watch theme mode

    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'RiverPod App',
          debugShowCheckedModeBanner: false,
          theme: _getLightTheme(),
          darkTheme: _getDarkTheme(),
          themeMode: themeMode, // use provider value
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }

  ThemeData _getLightTheme() => AppTheme.lightTheme;

  ThemeData _getDarkTheme() => AppTheme.darkTheme;
}

