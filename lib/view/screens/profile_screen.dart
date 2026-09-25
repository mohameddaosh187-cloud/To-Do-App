import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/app_dialog.dart';
import 'package:todo_app/core/app_routes.dart';
import 'package:todo_app/data/model/user_model.dart';
import 'package:todo_app/view/widgets/custom_material_button.dart';
import 'package:todo_app/view/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var fullName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xffE8ECF5),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.person, size: 100, color: Color(0xff3F51B5)),
            ),
            SizedBox(height: 20),
            Text(
              "Create Your Profile",
              style: TextStyle(fontSize: 30, fontWeight: .bold),
            ),
            SizedBox(height: 10),
            Text(
              "Add your name and profile picture",
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),

            CustomTextFormField(
              label: "Full Name",
              hint: "Enter your name",
              controller: fullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            CustomMaterialButton.name(
              text: "Create",
              onPressed: () async {
                AppDialog.showLoading(context);
                var userBox = Hive.box<UserModel>('User');
                await userBox
                    .put("UserKey", UserModel(fullName: fullName.text))
                    .then((value) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(AppRoutes.home);
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                      AppDialog.showError(context, error);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
