import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class AppColors
{
  static Color BackgroundColor=Color(0xffFAFFA5);
  static Color MainTextColor=Colors.black;
  static Color HyperTextColor=Color(0xff0e80f6);
  static Color buttonColor=Color(0xff07488a);
  static Color buttonTextColor=Colors.white;
  static Color TextFiledBackgroundColor=Color(0xffF2EAEA);
}
class AppStrings
{
  static String SignUpString="Sign Up";
  static String LoginString="Log In";
  static String UserNameString="User Name";
  static String PasswordString="Password";
  static String ConfirmPasswordString="Confirm Password";
  static String EmailString="E-mail";
  static String DoNotHaveString="Do not have an account?";
  static String IHaveString="I have an account";
  static String OrString="OR";
  static String GuestString="Continue As Guest";
  static String SaveString="Save";
  static String MainPageHeaderString="Today’s  To  Do’s";
  static String AddNewItemString="Add New Item";
  static String NewItemHint="TODO.......";
}

class AppStyles
{
  static var ButtonFontStyle=TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w700,
  color: AppColors.buttonTextColor
  );
  static var MainFontStyle=TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.MainTextColor
  );
  static var HyperMainFontStyle=TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.HyperTextColor
  );
  static var ItemTitleFontStyle=TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.MainTextColor
  );
  static var ItemCheckedTitleFontStyle=TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.MainTextColor,
    decoration: TextDecoration.lineThrough,
  );
  static var ItemTimeFontStyle=TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
      color: AppColors.HyperTextColor
  );
}