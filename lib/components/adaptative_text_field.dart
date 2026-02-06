import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget{
  final String placeholder;
  final TextEditingController controller;
  final TextInputType? keyBoardType;
  final void Function(String)? submitAction;

  const AdaptativeTextField({required this.placeholder,required this.controller, this.keyBoardType = TextInputType.text, this.submitAction});

  @override
  Widget build(BuildContext context){
    //print("build() AdaptativeTextField");
    return Platform.isIOS ? Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(
        placeholder: placeholder,
        controller: controller,
        onSubmitted: submitAction,
        keyboardType: keyBoardType,
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12
        ),
        
      ),
    ) : TextField(
      decoration: InputDecoration(label: Text(placeholder)),
      controller: controller,
      onSubmitted: submitAction,
      keyboardType: keyBoardType,
    );
  }
}