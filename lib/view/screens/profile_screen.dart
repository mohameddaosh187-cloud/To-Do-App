import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

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
              controller: fullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              onPressed: () {},
              color: Color(0xff515B92),
              padding: EdgeInsets.all(15),
              minWidth: 400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(25),
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: .bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.label,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: .bold)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hint: Text("Enter your name", style: TextStyle(color: Colors.grey)),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
