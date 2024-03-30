import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  String? text = "";
  IconData? icon;
  bool? isIcon;
  AppButton(
      {super.key,
      this.isIcon = false,
      this.text,
      this.icon,
      required this.color,
      required this.backgroundColor,
      required this.borderColor,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.0)),
      child: isIcon == false
          ? Center(
              child: Text(
              text!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color, fontSize: 25),
            ))
          : Icon(
              icon,
              color: color,
            ),
    );
  }
}
