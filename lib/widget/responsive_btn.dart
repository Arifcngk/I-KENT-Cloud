
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_belediyecilik/misc/colors.dart';
import 'package:e_belediyecilik/widget/app_text.dart';
class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;

  ResponsiveButton({
    super.key,
    this.width,
    this.isResponsive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: width,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isResponsive == true
                ? AppText(size: 18, text: "Book Trip Now", color: Colors.white)
                : Text(""),
            Image.asset("img/button-one.png"),
          ],
        ),
      ),
    );
  }
}
