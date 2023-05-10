import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/components/index.dart';

class LoginAction extends StatelessWidget {
  const LoginAction({
    super.key,
    required this.onTapForgotPassword,
    required this.onTapLogin,
    required this.onTapFacebook,
    required this.onTapGoogle,
    required this.onTapSignUp,
  });

  final VoidCallback? onTapForgotPassword;
  final VoidCallback? onTapLogin;
  final VoidCallback? onTapFacebook;
  final VoidCallback? onTapGoogle;
  final VoidCallback? onTapSignUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: onTapForgotPassword,
              child: const Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
                  AppStrings.forgotPasswordQuestion,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppButton(
            title: AppStrings.login,
            buttonStyle: ButtonStyles.elevated,
            onPressed: onTapLogin,
          ),
        ),
        // const SizedBox(height: 15),
        // Center(
        //   child: Text(
        //     AppStrings.or,
        //     style:
        //         TextStyles.mulishBody02.copyWith(color: AppColors.bluePrimary),
        //   ),
        // ),
        // const SizedBox(height: 15),
        // Row(
        //   children: [
        //     const Spacer(),
        //     InkWell(
        //       onTap: onTapFacebook,
        //       child: Image.asset(
        //         ImagePaths.facebookIcon.assetName,
        //         height: 48,
        //       ),
        //     ),
        //     const SizedBox(width: 22),
        //     InkWell(
        //       onTap: onTapGoogle,
        //       child: Image.asset(
        //         ImagePaths.googleIcon.assetName,
        //         height: 48,
        //       ),
        //     ),
        //     const Spacer(),
        //   ],
        // ),
        const SizedBox(height: 30),
        Center(
          child: Text.rich(
            TextSpan(
                text: AppStrings.dontHaveAccount,
                style: AppStyles.body02,
                children: [
                  TextSpan(
                      text: AppStrings.signUp,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => onTapSignUp?.call(),
                      style: AppStyles.body02.copyWith(
                          color: Theme.of(context).colorScheme.primary)),
                ]),
          ),
        ),
      ],
    );
  }
}
