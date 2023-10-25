import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/helpers.dart';
import 'package:sizer/sizer.dart';
import 'package:to_do_app/presentation/screens/main_page.dart';
import 'login_page.dart';


class SplashScreen extends StatelessWidget {

  void navigateToNewScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () async{
      if(FirebaseAuth.instance.currentUser?.uid == null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
      }
      else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    navigateToNewScreen(context);
    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      body: Center(
        child: Image.asset('assets/images/logo.png',width: 60.w,height: 20.h,),
      ),
    );
  }
}
