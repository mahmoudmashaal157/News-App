import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_architecture/core/util/snackbar_message.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/loading_widget.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_detail_widgets/delete_dialog_widget.dart';

class PostDeleteBtn extends StatelessWidget {

  final int postId;

  PostDeleteBtn({required this.postId});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent)
        ),
        onPressed: (){
          deleteDialog(context);
        },
        icon: Icon(Icons.delete),
        label: Text("Delete")
    );
  }


  void deleteDialog(BuildContext context){
    showDialog(context: context, builder: (BuildContext contetx){
      return BlocConsumer<AddDeleteUpdateBloc,AddDeleteUpdateState>
        (
        listener: (context, state) {
          if(state is AddDeleteUpdatePostErrorState){

            Navigator.pop(context);

            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }

          else if (state is AddDeleteUpdatePostSuccessfullyState){
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context){
              return PostsPage();
            }), (route) => false);
          }

        },
        builder: (context, state) {
          if(state is AddDeleteUpdatePostLoadingState){
            return AlertDialog(
              title: LoadingWidget(),
            );
          }
          return DeleteDialogWidget(postId: postId);
        },
      );
    });
  }

}
