import 'package:flutter/material.dart';

class MajorTextField extends StatelessWidget {
  final titleLabel;
  final maxLength;
  final icon;
  final controller;
  final inputType;
  final Function fieldSubmit;
  final focusnode;
  final validator;
  final inputAction;
  final maxLines;
  final obsecureText;
  final String initValues;
  final Function onSaved;

  MajorTextField(
      {this.onSaved,
      this.initValues,
      @required this.titleLabel,
      @required this.maxLength,
      @required this.icon,
      @required this.validator,
      this.controller,
      @required this.inputAction,
      this.focusnode,
      this.maxLines,
      this.obsecureText = false,
      this.fieldSubmit,
      @required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: initValues,
        maxLength: maxLength,
        controller: controller,
        onSaved: onSaved,
        keyboardType: inputType,
        validator: validator,
        obscureText: obsecureText,
        textInputAction: inputAction,
        onFieldSubmitted: fieldSubmit,
        maxLines: maxLines,
        focusNode: focusnode,
        decoration: InputDecoration(
          labelText: titleLabel,
          suffixIcon: Icon(
            icon,
            color: Theme.of(context).accentColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
