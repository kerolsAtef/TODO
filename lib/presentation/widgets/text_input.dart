import 'package:flutter/material.dart';
import '../helpers.dart';
import 'package:sizer/sizer.dart';

class InputTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  IconData? icon;
  bool multiLine;

  InputTextField({required this.hint,required this.controller,this.icon,required this.multiLine});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height:multiLine?20.h: 8.h,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.TextFiledBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        maxLines:multiLine? 5:null,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,

          border: InputBorder.none, // Hide default TextField border
          suffixIcon: Icon(
            icon, // The icon you want to display on the right
            color: Colors.grey, // Icon color
          ),
        ),
      ),
    );
  }
}
