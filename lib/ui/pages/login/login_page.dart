import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/index.dart';
import 'package:movie_app/ui/pages/index.dart';

import '../../components/index.dart';
import 'widgets/index.dart';

enum _LoginSection {
  loginHeading,
  loginInput,
  loginAction, //forgot, login, SSO login, signup,
  loginFinger,
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          ListView.builder(
            itemBuilder: (_, index) => _itemBuilder(context, index),
            itemCount: _LoginSection.values.length,
          )
        ],
      ),
    );
  }

  _itemBuilder(BuildContext context, int index) {
    switch (_LoginSection.values[index]) {
      case _LoginSection.loginHeading:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 68),
              child: Image.asset(ImagesPath.login.assetName),
            ),
            const Text(
              AppStrings.login,
              style: AppStyles.header,
            ),
            const SizedBox(height: 4),
            const Text(
              AppStrings.welcomeBack,
              textAlign: TextAlign.center,
              style: AppStyles.body02,
            ),
            const SizedBox(height: 15),
          ],
        );
      case _LoginSection.loginInput:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppTextField(
                controller: TextEditingController(),
                hintText: AppStrings.username,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppTextField(
                controller: TextEditingController(),
                hintText: AppStrings.password,
                hasSuffixIcon: true,
                obscureText: true,
              ),
            ),
            const SizedBox(height: 6),
          ],
        );
      case _LoginSection.loginAction:
        return LoginAction(
          onTapForgotPassword: () => _onForgotPasswordTap(context),
          onTapLogin: () {},
          onTapFacebook: () {},
          onTapGoogle: () {},
          onTapSignUp: () => _onSignUpTap(context),
        );
      // case _LoginSection.loginFinger:
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 40),
      //     child: Center(
      //         child: Image.asset(
      //       activeFinger == true
      //           ? ImagePaths.fingerActiveIcon.assetName
      //           : ImagePaths.fingerDeactiveIcon.assetName,
      //       height: 72,
      //     )),
      //   );
      default:
        return const SizedBox();
    }
  }

  _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const SignUpPage(),
    ));
  }

  _onForgotPasswordTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const ForgotPasswordPage(),
    ));
  }
}
