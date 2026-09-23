import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const new name({super.key, required this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color(0xff515B92),
      padding: EdgeInsets.all(15),
      minWidth: 400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(25),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: .bold, color: Colors.white),
      ),
    );
  }
}
