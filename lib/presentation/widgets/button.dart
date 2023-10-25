import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../helpers.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key,
     required this.data, required this.fun
   });


  String data;
  VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: fun,
      child: Container(
        width: 60.w,
        height: 7.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.buttonColor
        ),
        child: Text(
          data,style: AppStyles.ButtonFontStyle
        ),
      ),
    );
  }
}
