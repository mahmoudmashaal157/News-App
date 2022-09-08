import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:news_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/loading_widget.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/posts_page_widgets/message_display_widget.dart';
import 'package:news_clean_architecture/features/posts/presentation/widgets/posts_page_widgets/post_list_widget.dart';

class PostsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BuildFloatingActionBtn(),
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Center(
        child: BuildBody(),
      ),
    );
  }
}

class BuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if(state is GetAllPostsLoadingState)
          return LoadingWidget();
        else if(state is GetAllPostsSuccessfullyState){
          return RefreshIndicator(
            onRefresh: ()=> _onRefresh(context),
            child: PostListWidget(
              posts:state.posts
            ),
          );
        }
        else if(state is GetAllPostsErrorState){
          return MessageDisplayWidget(message:state.message ,);
        }
        return LoadingWidget();
      },


    );
  }
}

Future<void> _onRefresh(BuildContext context)async{
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}

class BuildFloatingActionBtn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            return PostAddUpdatePage(isUpdatePost: false);
          }));
        },
      child: Icon(Icons.add),
    );
  }
}


