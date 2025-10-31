import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/app_snackbar.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/custom_text_form_field.dart';
import 'package:river_pod/core/language/custom_localized_text.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';
import 'package:river_pod/core/utils/validators/app_validator.dart';
import 'package:river_pod/route/routes_name.dart';

import '../../../../core/language/app_local.dart';
import '../../../../core/language/local_notifier_widget.dart';
import '../view_model/login_view_model.dart';


class LoginScreen extends ConsumerWidget {
   LoginScreen({super.key});



  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginNotifierProvider);
    final notifier = ref.read(loginNotifierProvider.notifier);
    final currentLangCode = ref.watch(localeProvider).languageCode;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w800),),
              SizedBox(height: 10.h),
              Text("Welcome Back!",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600),),
              SizedBox(height: 40.h),
              CustomTextField(
                  value: state.email,
                  onChanged: notifier.setEmail,
                  validator: AppValidator.validateEmail,
                  hintText: notifier.getText(AppLocale.emailHintText,currentLangCode)
              ),

             SizedBox(height: 10.h),
              CustomTextField(
                value: state.password,
                onChanged: notifier.setPassword,
                validator: AppValidator.validatePassword,
                hintText: notifier.getText(AppLocale.passwordHintText,currentLangCode),
                obscureText: true, // enables eye icon
              ),


             SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context, RouteNames.forgetEmailScreen);
                  }, child: Text("Forget Password",style: TextStyle(color: Colors.blue),))),
              SizedBox(height: 16.h),

              // Button or Loading
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isLoading
                      ? null // disable button while loading
                      : () async {

                    if(_loginFormKey.currentState!.validate()){
                      final result = await notifier.login(
                        context: context,
                      );

                      if(result){
                        Navigator.pushNamedAndRemoveUntil(context, RouteNames.homeScreen, (route)=>false);
                        AppSnackBar.showSuccess(context, "Login Successfully");
                      }

                    }
                    //Navigator.pushNamed(context, RouteNames.homeScreen );

                  },
                  child: state.isLoading
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

              if (state.error != null)
                Text(
                  state.error!,
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
      ),
    );
  }
}
