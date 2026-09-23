import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/app_dialog.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/view/widgets/choose_color_widget.dart';
import 'package:todo_app/view/widgets/custom_material_button.dart';
import 'package:todo_app/view/widgets/custom_text_form_field.dart';

import 'dart:developer';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String dropdownButtonValue = "Pending";
  var titleTask = TextEditingController();
  var desTask = TextEditingController();
  int colorSelected = 0xff2196F3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(fontSize: 25, fontWeight: .bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 15,
          crossAxisAlignment: .start,
          children: [
            CustomTextFormField(
              label: "Title Task",
              hint: "Enter task title",
              controller: titleTask,
            ),
            CustomTextFormField(
              label: "Description Task",
              hint: "Enter task description",
              maxLines: 4,
              controller: desTask,
            ),
            Text(
              "Status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            DropdownButtonFormField(
              value: dropdownButtonValue,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: "Pending",
                  child: Text(
                    "Pending",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                DropdownMenuItem(
                  value: "Done",
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
              onChanged: (value) {
                dropdownButtonValue = value ?? "Pending";
                setState(() {});
              },
            ),
            ChooseColorWidget(
              clickColor: (color) {
                log(color.toString());
                colorSelected = color;
              },
            ),

            CustomMaterialButton.name(
              onPressed: () async {
                log("Title: ${titleTask.text}");
                log("Des: ${desTask.text}");
                log("Status: $dropdownButtonValue");
                log("Color: $colorSelected");
                AppDialog.showLoading(context);
                var taskBox = Hive.box<TaskModel>('Tasks');
                await taskBox
                    .add(
                      TaskModel(
                        title: titleTask.text,
                        description: desTask.text,
                        status: dropdownButtonValue == "Pending"
                            ? .pending
                            : .done,
                        colorHex: colorSelected,
                      ),
                    )
                    .then((value) {
                      Navigator.of(context).pop();
                      titleTask.clear();
                      desTask.clear();
                      colorSelected = 0xff2196F3;
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                      AppDialog.showError(context, error);
                    });
              },
              text: "Save Task",
            ),
          ],
        ),
      ),
    );
  }
}
