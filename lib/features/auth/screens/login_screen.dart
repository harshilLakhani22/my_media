import 'package:coonch/common/widgets/common_elevated_button.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/common/widgets/or_widget.dart';
import 'package:coonch/features/auth/controllers/auth_controller.dart';
import 'package:coonch/features/auth/screens/reset_password.dart';
import 'package:coonch/features/auth/screens/signup_screen.dart';
import 'package:coonch/features/auth/widgets/auth_heading.dart';
import 'package:coonch/features/auth/widgets/social_button.dart';
import 'package:coonch/features/auth/widgets/term_and_policy.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(MSizes.defaultSpace),
                child: Column(
                  children: [
                    /// App Logo
                    Image.asset(MImages.imgHomeAppMain),
                    const SizedBox(height: MSizes.spaceBtwInputFields),
                    /// Sign Up Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// SignUp Title & SubTitle
                        const AuthHeading(
                            title: MTexts.strLogIn,
                            subTitle: MTexts.strLogInSubTitle),
          
                        /// SignUp Form
          
                        /// Email
                        CommonTextField(
                          controller: authController.emailController,
                          hint: MTexts.strEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: MSizes.spaceBtwInputFields),
          
                        /// Password
                        Obx(
                          () => CommonTextField(
                            controller: authController.passwordController,
                            hint: MTexts.strPassword,
                            isObscureText: authController.isPasswordHidden.value,
                            icon: authController.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            fillColor:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? MColors.black
                                    : MColors.grey),
                            onTap: () {
                              authController.isPasswordHidden.value =
                                  !authController.isPasswordHidden.value;
                            },
                          ),
                        ),
                      ],
                    ),
          
                    /// Keep Me SignIn
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: authController.keepSignedIn.value,
                            onChanged: authController.toggleKeepSignedIn,
                          ),
                        ),
                        const Text(
                          MTexts.strKeepMeSignedIn,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.to(ResetPasswordScreen()),
                          child: const Text(
                            MTexts.strForgotYourPassword,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MSizes.spaceBtwSections * 1.5),
          
                    /// LogIn Button
                    CommonElevatedButton(
                      onPressed: () {
                        if (authController.onLoginScreenValidation()) {
                          authController.onLogin();
                        }
                      },
                      title: MTexts.strLogIn,
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
          
                    /// Divider
                    const OrWidget(title: MTexts.strOr),
          
                    /// Login with others
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SocialLoginButton(
                          onTap: () {},
                          imgPath: MImages.imgGoogleAuth,
                          isOther: true,
                        ),
                        SocialLoginButton(
                            onTap: () {}, imgPath: MImages.imgFaceBookAuth),
                        SocialLoginButton(
                            onTap: () {}, imgPath: MImages.imgInstagramAuth),
                      ],
                    ),
                    const SizedBox(height: MSizes.spaceBtwSections),
          
                    /// Already have Account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          MTexts.strAlreadyAcc,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        GestureDetector(
                          onTap: () {
                            authController.clearControllers();
                            Get.to(SignUpScreen());
                          },
                          child: const Text(
                            MTexts.strSigunUp,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
          
                    /// Term & Policy
                    TermAndPolicy(onPolicyTap: () {}, onTermTap: () {})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
