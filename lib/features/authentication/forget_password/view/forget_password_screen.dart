
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/core/utils/validators/app_validator.dart';
import 'package:river_pod/features/authentication/forget_password/view_model/forget_view_model.dart';

import '../../../../../core/common/widgets/new_custon_widgets/custom_text_form_field.dart';

import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/common/widgets/new_custon_widgets/app_snackbar.dart';
import '../../../../core/common/widgets/new_custon_widgets/custom_app_bar.dart';
import '../../../../core/language/custom_localized_text.dart';
import '../../../../route/routes_name.dart';



class ForgetEmailScreen extends ConsumerWidget {
  ForgetEmailScreen({super.key});
  
  
  final forgetEmailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final state = ref.watch(forgetNotifierProvider);
    final notifier = ref.read(forgetNotifierProvider.notifier);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: forgetEmailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(24),),
                CustomAppBar(firstText: 'Reset password',secondText: "Please enter your email to reset the password",),
                SizedBox(height: getHeight(71),),

                CustomTextField(
                  value: state.email,
                  onChanged: notifier.setEmail,
                  validator: AppValidator.validateEmail,
                  hintText: "Type Your Email",
                 // prefixIcon: Image.asset(IconPath.e,),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null // disable button while loading
                        : () async {

                      if(forgetEmailFormKey.currentState!.validate())
                      {
                         notifier.forgetEmail(
                          context: context,
                        );





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
                        : Text("Continue"),
                  ),
                ),




                SizedBox(height: getHeight(40),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


