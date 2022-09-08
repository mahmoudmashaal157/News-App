import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {

  final TextEditingController controller;
  final bool multiLines;
  final String name;

  TextFormFieldWidget({required this.controller,required this.name, required this.multiLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't be Empty" : null,
        decoration: InputDecoration(
          hintText: "$name",
        ),
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
      ),
    );
  }
}
