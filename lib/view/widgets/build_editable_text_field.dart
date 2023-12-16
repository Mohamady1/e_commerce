import 'package:flutter/material.dart';

class EditableTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const EditableTextField(this.labelText, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        readOnly: labelText == "Email" ? true : false,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            enabledBorder: OutlineInputBorder(),
            border: OutlineInputBorder()),
      ),
    );
  }
}
