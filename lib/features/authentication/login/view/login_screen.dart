import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/app_snackbar.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/custom_text_form_field.dart';
import 'package:river_pod/core/language/custom_localized_text.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';
import 'package:river_pod/route/routes_name.dart';

import '../../../../core/language/app_local.dart';
import '../../../../core/language/local_notifier_widget.dart';
import '../view_model/login_view_model.dart';


class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    final loginState = ref.watch(loginNotifierProvider);
    final notifier = ref.read(loginNotifierProvider.notifier);
    final currentLangCode = ref.watch(localeProvider).languageCode;

    return Scaffold(
      //appBar: AppBar(title: CustomLocalizedText(AppLocale.loginAppBarText)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Login",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w800),),
            SizedBox(height: 10.h),
            Text("Welcome Back!",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600),),
            SizedBox(height: 40.h),
            CustomTextField(controller: _emailController, hintText: _getText(AppLocale.emailHintText,currentLangCode)),

           SizedBox(height: 10.h),
            CustomTextField(
              controller: _passwordController,
              hintText: _getText(AppLocale.passwordHintText,currentLangCode),
              obscureText: true, // enables eye icon
            ),

            // TextFormField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     hintText: _getText(AppLocale.passwordHintText,currentLangCode),
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8)),
            //   ),
            // ),
           SizedBox(height: 6.h),
            Align(
              alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){}, child: Text("Forget Password",style: TextStyle(color: Colors.blue),))),
            SizedBox(height: 16.h),

            // Button or Loading
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loginState.isLoading
                    ? null // disable button while loading
                    : () async {
                  //Navigator.pushNamed(context, RouteNames.homeScreen );
                 final result = await notifier.login(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    context: context,
                  );

                 if(result){
                   Navigator.pushNamedAndRemoveUntil(context, RouteNames.homeScreen, (route)=>false);
                   AppSnackBar.showSuccess(context, "Login Successfully");
                 }
                },
                child: loginState.isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : CustomLocalizedText(AppLocale.submitButtonText),
              ),
            ),

            const SizedBox(height: 12),

            if (loginState.error != null)
              Text(
                loginState.error!,
                style: const TextStyle(color: Colors.red),
              ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text("Don't have account",style: TextStyle(fontSize: 16.sp),),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RouteNames.signUpScreen);
                }, child: Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: 16.sp),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
