import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/components/index.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0 - MediaQuery.of(context).viewInsets.bottom,
            left: 0,
            child: Image.asset(
              ImagesPath.loginBackground1.assetName,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              ImagesPath.loginBackground2.assetName,
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 68),
                child: Image.asset(
                  ImagesPath.forgotPassword1.assetName,
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  AppStrings.forgotPassword,
                  style: AppStyles.header,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                AppStrings.enterEmailBelow,
                textAlign: TextAlign.center,
                style: AppStyles.body02,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: TextEditingController(),
                hintText: AppStrings.email,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              AppButton(
                title: AppStrings.send,
                onPressed: () {},
                buttonStyle: ButtonStyles.elevated,
              ),
              const SizedBox(height: 14),
            ],
          ),
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  ImagesPath.backIcon.assetName,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
