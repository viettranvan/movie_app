import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/components/index.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              bottom: 0 - MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              child: Image.asset(
                ImagesPath.loginBackground1.assetName,
                // height: MediaQuery.of(context).size.height * 2 / 3,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                ImagesPath.loginBackground2.assetName,
                // height: MediaQuery.of(context).size.height * 2 / 3,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 68),
                        child: Image.asset(
                          ImagesPath.illustration.assetName,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          AppStrings.signUp,
                          style: AppStyles.header,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        AppStrings.createNewAccount,
                        textAlign: TextAlign.center,
                        style: AppStyles.body02,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: AppStrings.usernameRequired,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: AppStrings.firstNameRequired,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        controller: TextEditingController(),
                        hintText: AppStrings.lastNameRequired,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _selectDateTime(context),
                        child: AppTextField(
                          controller: TextEditingController(),
                          hintText: AppStrings.dobOptional,
                          enabled: false,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _selectGender(context),
                        child: Stack(
                          children: [
                            AppTextField(
                              enabled: false,
                              controller: TextEditingController(),
                              hintText: AppStrings.genderOptional,
                            ),
                            Positioned(
                              right: 12,
                              top: 10,
                              bottom: 10,
                              child: Image.asset(
                                ImagesPath.arrowDownIcon.assetName,
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  title: AppStrings.save,
                  onPressed: () {},
                  buttonStyle: ButtonStyles.elevated,
                ),
                const SizedBox(height: 14),
                Center(
                  child: Text.rich(
                    TextSpan(
                        text: AppStrings.alreadyHaveAccount,
                        style: AppStyles.body02,
                        children: [
                          TextSpan(
                              text: AppStrings.loginNow,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pop(context),
                              style: AppStyles.body02.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ]),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _selectGender(BuildContext context) {
    GenderBottomSheet.show(
      context: context,
      // gender: 'female'.toGender,
    );
  }

  _selectDateTime(BuildContext context) {
    if (Platform.isAndroid) {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime(DateTime.now().year + 20, 1, 1),
      );
    } else if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {},
            ),
          ),
        ),
      );
    }
  }
}
