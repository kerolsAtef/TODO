import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:to_do_app/presentation/helpers.dart';
import 'package:to_do_app/presentation/widgets/button.dart';
import 'package:to_do_app/data/remote/firestore_service.dart';
import 'package:to_do_app/domain/models/to_do_model.dart';
import 'package:to_do_app/data/local/db.dart';

import '../view_models/functions.dart';
import '../widgets/text_input.dart';
import 'main_page.dart';

class InsertPage extends StatefulWidget {
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController itemController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();// Selected time for the item.
  bool Visible=false;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          picked.hour,
          picked.minute,
        );
        Visible=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              Text(AppStrings.AddNewItemString, style: AppStyles.MainFontStyle),
              SizedBox(height: 5.h),
              InputTextField(hint: AppStrings.NewItemHint, controller: itemController, multiLine: true),
              SizedBox(height: 1.h),
              GestureDetector(

                onTap: () {
                  print("here1");
                  _selectTime(context);
                  print(selectedDateTime);
                }, // Show time picker.
                child: Image.asset("assets/images/time.png", width: 20.w, height: 6.h),
              ),
              Visibility(
                  visible: true,
                  child: Text("Selected Time: ${(selectedDateTime.toLocal()).toString().split(' ')[1].substring(0,5)}", style: AppStyles.HyperMainFontStyle)),
              SizedBox(height: 5.h),
              CustomButton(
                data: AppStrings.SaveString,
                fun: () async {
                  if(!itemController.text.isEmpty&& !itemController.text.trim().isEmpty)
                 {
                   showLoaderDialog(context);
                   print("here2");
                   // Save the item to Firestore with the selected time.


                   var connectivityResult = await Connectivity().checkConnectivity();

                   if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                     print("here2");
                     await FirestoreService(user!.uid).createTodo(
                       Todo(
                         id: DateTime.now().toIso8601String(),
                         title: itemController.text,
                         time: selectedDateTime.toString(),
                         isChecked: 0,
                       ),
                     );
                   }

                   print("here3");
                   // Save the item to local storage (Sqflite) with the selected time.
                   showLoaderDialog(context);
                   final todo = Todo(
                     id: DateTime.now().toIso8601String(), // Generate a unique ID.
                     title: itemController.text,
                     time: selectedDateTime.toString(),
                     isChecked: 0,
                   );
                   final database = LocalDatabase();
                   await database.initialize();
                   await database.createTodo(todo);
                   // Navigate back to the previous page.
                   Navigator.pop(context);
                   Navigator.of(context).pushAndRemoveUntil(
                     MaterialPageRoute(builder: (context) => MainPage()),
                         (route) => false,
                   );
                 }
                  else
                    {
                      ShowSnackBar("Error,You should write title", context);
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
