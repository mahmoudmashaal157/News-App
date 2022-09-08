import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {

  final int postId;

  DeleteDialogWidget({required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure ?"),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("No")
        ),
        TextButton(
            onPressed: (){
              BlocProvider.of<AddDeleteUpdateBloc>(context).add(DeletePostEvent(postId: postId));
            },
            child: Text("Yes")
        ),
      ],
    );
  }
}
