import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/helpers.dart';
import 'package:sizer/sizer.dart';
import 'package:to_do_app/presentation/screens/main_page.dart';
import 'package:to_do_app/presentation/screens/signup_page.dart';
import 'package:to_do_app/presentation/view_models/functions.dart';
import 'package:to_do_app/presentation/widgets/button.dart';
import 'package:to_do_app/presentation/widgets/text_input.dart';
import '../../data/remote/firebase.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
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
                data: AppStrings.LoginString,
                fun: () async {
                  final email = emailController.text;
                  final password = passController.text;

                  if (email.isNotEmpty && password.isNotEmpty) {
                    showLoaderDialog(context);
                    final user = await authService.signInWithEmailAndPassword(email, password);
                    if (user != null) {
                      print("here1");
                      // Navigate to the main page upon successful login.
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );

                    } else {
                      print("here2");
                      Navigator.pop(context);
                      ShowSnackBar("Error,please Try again", context);

                    }
                  } else {
                    print("here3");
                    // Handle empty email or password fields.
                   ShowSnackBar("Error, please check email and password", context);
                  }
                },
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppStrings.DoNotHaveString, style: AppStyles.MainFontStyle),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text(AppStrings.SignUpString, style: AppStyles.HyperMainFontStyle),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Text(AppStrings.OrString, style: AppStyles.MainFontStyle),
              SizedBox(height: 1.h),
              GestureDetector(
                onTap: () async{
                  //   handle guest login here.
                  final user = await authService.signInAnonymously();
                  showLoaderDialog(context);
                  if (user != null) {
                    // Navigate to the main page upon successful login.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ShowSnackBar("Error,please Try again", context);
                    Navigator.pop(context);
                  }
                },
                child: Text(AppStrings.GuestString, style: AppStyles.HyperMainFontStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
