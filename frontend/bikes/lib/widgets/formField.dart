// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  String labelText;
  String hintText;
  TextEditingController controller;
  Function(String value) onChanged;
  // ignore: non_constant_identifier_names
  dynamic validator;
  bool hideText;
  TextInputType textInputType;

  CustomField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.hideText,
    required this.textInputType,
    required this.validator,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: widget.hideText,
      keyboardType: widget.textInputType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Color.fromARGB(204, 110, 101, 101)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(211, 246, 245, 245), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(213, 3, 35, 220), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      ),
    );
  }
}

class AccountType extends StatefulWidget {
   String currentSelectedValue;
   AccountType({
    
    required this.currentSelectedValue,
  });

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  var accounntType = ["Worker", "Client"];
 
  @override
  Widget build(BuildContext context) {
    return FormField(
      
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: const InputDecoration(
            labelText: "Account Type",
            // hintText: widget.hintText,
            labelStyle: const TextStyle(color: Colors.white),
            hintStyle:
                const TextStyle(color: Color.fromARGB(204, 110, 101, 101)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(211, 246, 245, 245), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(213, 3, 35, 220), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
          ),
          isEmpty: widget.currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.currentSelectedValue,
              isDense: true,
              onChanged: (newValue) {
                setState(() {
                  widget.currentSelectedValue = newValue!;
                  state.didChange(newValue);
                });
              },
              items: accounntType.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // String choice() {
  //   return _currentSelectedValue;
  // }
}
