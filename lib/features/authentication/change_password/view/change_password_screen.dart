import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/widgets/new_custon_widgets/custom_text_form_field.dart';
import '../../../../../core/common/widgets/new_custon_widgets/custom_app_bar.dart';


import '../../../../../core/utils/constants/app_sizes.dart';

import '../view_model/change_password_view_model.dart';

class ResetPasswordScreen extends ConsumerWidget {
   ResetPasswordScreen({super.key,});


  final changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // final controller = Get.find<ChangePasswordController>();


    final state = ref.watch(changePasswordNotifierProvider);
    final notifier = ref.read(changePasswordNotifierProvider.notifier);


    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final token = args?['token'] ?? '';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: changePasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(24)),
                CustomAppBar(
                  firstText: 'Set New Password',
                  secondText:
                      "Create your new password so you can share your memories again.",
                ),
                SizedBox(height: getHeight(32)),
                CustomTextField(
                  value: state.newPassword,
                  onChanged: notifier.setPassword,
                  hintText: "New Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),

                SizedBox(height: getHeight(20)),
                CustomTextField(
                  value: state.confirmPassword,
                  onChanged: notifier.setConfirmPassword,
                  hintText: "Confirm your new password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password is required";
                    }
                    if (value != state.confirmPassword) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),

                Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null // disable button while loading
                        : () async {

                      if(changePasswordFormKey.currentState!.validate())
                      {
                        // notifier.(
                        //   context: context,
                        // );





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
                        : Text("Submit"),
                  ),
                ),
                SizedBox(height: getHeight(40)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
