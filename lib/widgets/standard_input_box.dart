import 'package:flutter/material.dart';

Widget standardInputBox({
  String labelText,
  String validatorPrompt,
  @required int flexVal,
  EdgeInsets addPadding = const EdgeInsets.all(10),
  TextEditingController controller,
  TextInputType keyboardType,
  @required Function onSaved,
  @required Function validatorCondition,
  bool obscureText = false,
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
