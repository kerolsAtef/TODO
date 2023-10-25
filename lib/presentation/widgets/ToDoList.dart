
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../domain/models/to_do_model.dart';
import '../helpers.dart';

Widget buildToDoList(List<Todo> items) {
  return Container(
    height: 88.h,
    child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
          padding: EdgeInsets.all(3),
          width: 90.w,
          height: 8.h,
          color: Colors.transparent,
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: item.isChecked==0?false:true,
            onChanged: (newValue) {
              // Handle checkbox state change here.
              // Update the isChecked status in Firestore or Sqflite accordingly.
              // You should also update the local and UI state.
            },
            title: Text(item.title, style: AppStyles.ItemCheckedTitleFontStyle),
            secondary: Text(item.time.toString(), style: AppStyles.ItemTimeFontStyle),
            contentPadding: EdgeInsets.all(0),
          ),
        );
      },
    ),
  );
}