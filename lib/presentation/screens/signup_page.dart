import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/helpers.dart';
import 'package:sizer/sizer.dart';
import 'package:to_do_app/presentation/screens/login_page.dart';
import 'package:to_do_app/presentation/screens/main_page.dart';
import 'package:to_do_app/presentation/widgets/button.dart';

import '../view_models/functions.dart';
import '../widgets/text_input.dart';
import '../../data/remote/firebase.dart'; // Import AuthService

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final authService = AuthService();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Image.asset("assets/images/logo.png", width: 60.w, height: 15.h),
              SizedBox(height: 5.h),
              InputTextField(
                hint: AppStrings.UserNameString,
                controller: nameController,
                icon: Icons.person_outline,
                multiLine: false,
              ),
              SizedBox(height: 2.h),
              InputTextField(
                hint: AppStrings.EmailString,
                controller: emailController,
                icon: Icons.email_outlined,
                multiLine: false,
              ),
              SizedBox(height: 2.h),
              InputTextField(
                hint: AppStrings.PasswordString,
                controller: passController,
                icon: Icons.lock_outline,
                multiLine: false,
              ),
              SizedBox(height: 5.h),
              CustomButton(
                data: AppStrings.SignUpString,
                fun: () async {
                  final name = nameController.text;
                  final email = emailController.text;
                  final password = passController.text;

                  if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                    final user = await authService.signUpWithEmailAndPassword(
                      email,
                      password,
                    );
                    showLoaderDialog(context);
                    if (user != null) {
                      // Navigate to the Main page upon successful registration.
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
                    } else {
                      // Handle registration failure.
                      Navigator.pop(context);
                      ShowSnackBar("Error in registration,please try again", context);

                    }
                  } else {
                    // Handle empty name, email, or password fields.
                    ShowSnackBar("Error in registration,please check fields", context);

                  }
                },
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppStrings.IHaveString, style: AppStyles.MainFontStyle),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(AppStrings.LoginString, style: AppStyles.HyperMainFontStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
