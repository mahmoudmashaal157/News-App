import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_architecture/core/util/snackbar_message.dart';
import 'package:news_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/loading_widget.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/post_add_update_widgets/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {

  final Post? post;
  final bool isUpdatePost;

  PostAddUpdatePage({this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isUpdatePost == true ? Text("Edit Post") : Text("Add post"),
      ),
      body:BuildBody(isUpdatePost: isUpdatePost,post: post),
    );
  }
}

class BuildBody extends StatelessWidget {

  final Post? post;
  final bool isUpdatePost;

  BuildBody({this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
        listener: (context, state) {
          if (state is AddDeleteUpdatePostSuccessfullyState) {
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
              return PostsPage();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AddDeleteUpdatePostLoadingState) {
            return LoadingWidget();
          }
          else if(state is AddDeleteUpdatePostErrorState){
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
          }
          return FormWidget(isUpdatepost: isUpdatePost, post: isUpdatePost==true? post : null );
            //FormWidget(isUpdatePost, post: isUpdatePost ? post : null);
        },
      ),
    );
  }
}

