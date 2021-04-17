import 'package:flutter/material.dart';

Widget standardInputBox({
  @required int flexVal,
  @required Function validatorCondition,
  @required Function onSaved,
  String labelText,
  String validatorPrompt,
  TextEditingController controller,
  bool obscureText = false,
  EdgeInsets addPadding = const EdgeInsets.all(10),
  TextInputType keyboardType,
}) {
  return Flexible(
    flex: flexVal,
    child: Padding(
      padding: addPadding,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(40.0),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
            ),
            keyboardType: keyboardType,
            onSaved: onSaved,
            obscureText: obscureText,
            validator: (value) {
              if (validatorCondition(value)) {
                return validatorPrompt;
              } else {
                return null; //validation passed
              }
            },
          ),
        ),
      ),
    ),
  );
}