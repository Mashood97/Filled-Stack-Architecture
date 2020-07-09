import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IOSTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final controller;
  final inputType;
  final Function fieldSubmit;
  final focusnode;
  final inputAction;
  final IconData iconData;
  final maxLines;
  final obsecureText;

  IOSTextField(
      {@required this.titleLabel,
      @required this.maxLength,
      this.controller,
      @required this.inputAction,
      this.iconData,
      this.focusnode,
      this.maxLines,
      this.obsecureText = false,
      this.fieldSubmit,
      @required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CupertinoTextField(
        maxLength: maxLength,
        controller: controller,
      enableSuggestions: true,
        keyboardType: inputType,
        obscureText: obsecureText,
        obscuringCharacter: '*',
        padding: EdgeInsets.all(15),
        suffix: Icon(
          iconData,
          color: Theme.of(context).accentColor,
        size: 30,
        ),


        placeholder: titleLabel,
        onSubmitted: fieldSubmit,
        textInputAction: inputAction,
        maxLines: maxLines,
        focusNode: focusnode,
      ),
    );
  }
}
