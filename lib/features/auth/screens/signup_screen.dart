import 'package:coonch/common/widgets/or_widget.dart';
import 'package:coonch/common/widgets/common_text_field.dart';
import 'package:coonch/features/auth/controllers/auth_controller.dart';
import 'package:coonch/features/auth/screens/almost_there_screen.dart';
import 'package:coonch/features/auth/screens/login_screen.dart';
import 'package:coonch/features/auth/widgets/auth_heading.dart';
import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/image_strings.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:coonch/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/common_elevated_button.dart';
import '../widgets/social_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

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
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    /// App Logo
                    // const AppLogoImage(imgString: MImages.imgHomeAppMain),
                    Image.asset(MImages.imgHomeAppMain),
          
                    /// Sign Up Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// SignUp Title & SubTitle
                        const AuthHeading(
                            title: MTexts.strSigunUp,
                            subTitle: MTexts.strSignUpSubtitle),
          
                        /// SignUp Form
          
                        /// Email
                        CommonTextField(
                          controller: authController.emailController,
                          hint: MTexts.strEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: MSizes.spaceBtwInputFields),
          
                        /// Password
                        CommonTextField(
                          controller: authController.passwordController,
                          hint: MTexts.strPassword,
                          isObscureText: true,
                        ),
                        const SizedBox(height: MSizes.spaceBtwInputFields),
          
                        /// Confirm Password
                        Obx(
                          () => CommonTextField(
                            controller:
                                authController.confirmPasswordController,
                            hint: MTexts.strConfirmPassword,
                            isObscureText:
                                authController.isPasswordHidden.value,
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
                    const SizedBox(height: MSizes.spaceBtwSections * 1.5),
          
                    /// SignUp Button
                    CommonElevatedButton(
                      onPressed: () {
                        if (authController.onSignUpScreenValidation()) {
                          Get.to(AlmostThereScreen());
                        }
                      },
                      title: MTexts.strSigunUp,
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
                    const SizedBox(height: MSizes.spaceBtwItems),
          
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
                            Get.to(LoginScreen());
                          },
                          child: const Text(
                            MTexts.strLogIn,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: MSizes.spaceBtwItems),
          
                    /// Term & Policy
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            MTexts.strTermOfServices,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(width: MSizes.lg),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            MTexts.strPrivacyPolicy,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
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
