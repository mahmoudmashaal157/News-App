import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {

  final void Function() onPressed;
  final bool isUpdatePost;

  FormSubmitBtn({required this.onPressed,required this.isUpdatePost});


  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        onPressed: () {
          this.onPressed();
        },
        icon: isUpdatePost ? Icon(Icons.edit) : Icon(Icons.add),
        label: isUpdatePost ? Text("Update") : Text("Add")
    );
  }
}
