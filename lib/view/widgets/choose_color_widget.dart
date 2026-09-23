import 'package:flutter/material.dart';

class ChooseColorWidget extends StatefulWidget {
  const new({super.key, required this.clickColor});
  final void Function(int) clickColor;

  @override
  State<ChooseColorWidget> createState() => _ChooseColorWidgetState();
}

class _ChooseColorWidgetState extends State<ChooseColorWidget> {
  List<int> colorHex = [
    0xff2196F3,
    0xff4CAF50,
    0xffFF9800,
    0xff9C27B0,
    0xffF44336,
    0xff009688,
  ];
  int selectedColor = 0xff2196F3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 5,
      mainAxisSize: .min,
      children: [
        Text(
          "Choose Color",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          spacing: 10,
          children: colorHex
              .map(
                (e) => colorContainer(e, selectedColor == e, () {
                  setState(() => selectedColor = e);
                  widget.clickColor(e);
                }),
              )
              .toList(),
        ),
      ],
    );
  }
}

Widget colorContainer(int colorHex, bool isSelected, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(colorHex),
        borderRadius: BorderRadius.circular(50),
        border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
      ),
    ),
  );
}
