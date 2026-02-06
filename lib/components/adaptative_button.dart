import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final Function()? onPressed;

  final Color? backGroundColor;
  final Color? textColor;

  AdaptativeButton({
    this.label,
    this.onPressed,
    this.backGroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    //print("build() AdaptativeButton");
    return Container(
      child: Platform.isIOS
          ? CupertinoButton(
              onPressed: onPressed,
              color: backGroundColor,
              child: Text(label as String, style: TextStyle(color: textColor)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backGroundColor,
                foregroundColor: textColor,
              ),
              child: Text(label as String),
            ),
    );
  }
}
